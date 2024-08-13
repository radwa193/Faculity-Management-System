import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:management_system_final_doctor/Network/local/cache_helper.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

const String supabaseUrl = 'https://ixwswhjospjukhbjqjzl.supabase.co/';
const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sRSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM';
final SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);
String myIp = 'Not Found';
bool isWorking = false;

Future<String> getIPv4Address() async {
  if (await Permission.location.request().isGranted) {
    final info = NetworkInfo();
    String? wifiIP = await info.getWifiIP();
    return wifiIP ?? 'Not Found';
  } else {
    return 'Permission Denied';
  }
}

String generateRandomChars() {
  const alphanumeric = 'abcdefghijklmnopqrstuvwxyz';
  final random = Random();
  String randomChars = '';

  for (int i = 0; i < 10; i++) {
    randomChars += alphanumeric[random.nextInt(alphanumeric.length)];
  }

  return randomChars;
}

class EncryptionWidget extends StatefulWidget {
  final String? courseId;
  EncryptionWidget({required this.courseId , super.key});

  @override
  _EncryptionWidgetState createState() => _EncryptionWidgetState();
}

class _EncryptionWidgetState extends State<EncryptionWidget> {
  late String _initialText;
  String _encryptedText = '';
  String _encryptionKey = '';
  WebSocketChannel? channel;
  List<WebSocketChannel> clients = [];
  Uint8List? qrImageData;
  bool firstEntry = true;

  @override
  void initState() {
    super.initState();
    _initialText = generateRandomChars();
    _initialize();
  }

  Future<void> _initialize() async {
    String ip = await getIPv4Address();
    setState(() {
      myIp = ip;
    });
    startWebSocketServer();
    generateEncryptionKey();
  }

  void startWebSocketServer() {
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.5:12345'));
    channel?.stream.listen(handleClient);
    print("WebSocket server running on ws://$myIp:12345");
  }

  void handleClient(dynamic message) {
    final clientChannel = WebSocketChannel.connect(Uri.parse(message));
    clients.add(clientChannel);
    print('Client connected: $message');
    clientChannel.sink.add(_encryptionKey);
    clientChannel.stream.listen((data) {}, onDone: () {
      clients.remove(clientChannel);
      print('Client disconnected: $message');
    }, onError: (error) {
      clients.remove(clientChannel);
      print('Error in client connection: $error');
    });
  }

  void generateEncryptionKey() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    _encryptionKey = String.fromCharCodes(letters.codeUnits.toList()..shuffle(random));
    broadcastEncryptionKey();
  }

  void encryptText() {
    setState(() {
      _encryptedText = String.fromCharCodes(_initialText.codeUnits.map((unit) {
        int alphaIndex = unit - 97;
        return _encryptionKey.codeUnitAt(alphaIndex);
      }));
    });
    String dataAndip = _encryptedText + "|" + myIp;
    String base64DataAndip = base64Encode(utf8.encode(dataAndip));
    generateQRCode(base64DataAndip);
    print(_encryptedText);
    if (firstEntry) {
      addAttendanceRecord();
      firstEntry = false;
    }
  }

  Future<void> generateQRCode(String data) async {
    final qrCode = QrPainter(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final picture = await qrCode.toPicture(500);
    final image = await picture.toImage(500, 500);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    setState(() {
      qrImageData = byteData?.buffer.asUint8List();
    });

    Timer(const Duration(seconds: 7), () {
      if (isWorking) {
        generateEncryptionKey();
        encryptText();
      }
    });
  }

  void broadcastEncryptionKey() {
    for (WebSocketChannel client in clients) {
      client.sink.add(_encryptionKey);
    }
    print("Broadcasted new encryption key to all clients.");
  }

  Future<void> addAttendanceRecord() async {
    final response = await supabase.from('Attendance').insert({
      'Attendance_TimeStamp': DateTime.now().toIso8601String(),
      'Attended_Group': '1',
      'TeachingStaff_ID': CacheHelper.getData(key : 'doctorID'),
      'Attended_course_ID': widget.courseId,
      'code': _initialText
    });

    if (response.error != null) {
      print('Error adding attendance record: ${response.error!.message}');
    } else {
      print('Attendance record added successfully: ${response.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              firstEntry = true;
              isWorking = false;
            });
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            qrImageData != null
                ? Image.memory(qrImageData!)
                : Text('Click the button to generate QR code'),
            SizedBox(height: 10),
            Text('IP Address: $myIp'),
            SizedBox(height: 20),
            isWorking
                ? ElevatedButton(
              onPressed: () {
                setState(() {
                  firstEntry = true;
                  isWorking = false;
                });
                Navigator.pop(context);
              },
              child: Text('Stop Attendance Session'),
            )
                : ElevatedButton(
              onPressed: () {
                setState(() {
                  isWorking = true;
                });
                generateEncryptionKey();
                encryptText();
              },
              child: Text('Start Attendance Session'),
            )
          ],
        ),
      ),
    );
  }
}
