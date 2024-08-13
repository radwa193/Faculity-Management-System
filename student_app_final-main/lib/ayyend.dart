import 'dart:convert';
import 'dart:io';
import 'package:final_student_version/provider/provider.dart';
import 'package:final_student_version/shared/dialogUtil/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';
import 'Network/local/cache_helper.dart';

const String supabaseUrl = 'https://ixwswhjospjukhbjqjzl.supabase.co/';
const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4d3N3aGpvc3BqdWtoYmpxanpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQwNDc2NTksImV4cCI6MjAyOTYyMzY1OX0.JSxIvZTW4nzgewv03qNh54wljgYVfQMQ2phiomPuTbM';
final SupabaseClient supabase = SupabaseClient(supabaseUrl, supabaseKey);

class DecryptionWidget extends StatefulWidget {
  final Future<dynamic> encryptedText;

  const DecryptionWidget({required this.encryptedText, super.key});

  @override
  _DecryptionWidgetState createState() => _DecryptionWidgetState();
}

class _DecryptionWidgetState extends State<DecryptionWidget> {
  String _decryptionKey = "Waiting for decryption key...";
  final TextEditingController _encryptedTextController = TextEditingController();
  String _decryptedText = '';
  String serverAddress = '';
  String cipher = '';
  Socket? socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _loadEncryptedText();
  }

  void decodeBase64(String base64Text) {
    String decodedText = utf8.decode(base64Decode(base64Text));
    List<String> parts = decodedText.split('|');
    cipher = parts.isNotEmpty ? parts[0] : '';
    serverAddress = parts.isNotEmpty ? parts[1] : '';
    connectToServer();
    decryptText();
  }

  void _loadEncryptedText() async {
    dynamic text = await widget.encryptedText;
    setState(() {
      decodeBase64(text);
      _encryptedTextController.text = cipher;
    });
  }

  void connectToServer() async {
    if (isConnected) {
      print('Already connected or attempt made.');
      return;
    }


      socket = await Socket.connect(serverAddress, 12345);
      setState(() {
        isConnected = true;
      });
      print('Connected to: ${socket!.remoteAddress.address}:${socket!.remotePort}');

      socket!.listen(
            (List<int> data) {
          var receivedData = String.fromCharCodes(data).trim();
          var keys = receivedData.split('\n');
          if (keys.isNotEmpty && keys.last.isNotEmpty) {
            setState(() {
              _decryptionKey = keys.last;
            });
            decryptText();
          }
        },
        onDone: () {
          print('Disconnected from server.');
        },
        onError: (error) {
          print('Error: $error');
          setState(() {
            _decryptionKey = "Failed to connect.";
          });
          DialogUtil.showMessage(
              context,
              "Failed to connect.",
              posActionTitle: "Ok"
          );
        },
        cancelOnError: true,
      );
  }

  void decryptText() async {
    if (_decryptionKey.isEmpty || _decryptionKey == "Waiting for decryption key...") {
      print('Decryption key is not available.');
      return;
    }

    setState(() {
      _decryptedText = String.fromCharCodes(_encryptedTextController.text.codeUnits.map((unit) {
        int index = _decryptionKey.indexOf(String.fromCharCode(unit));
        return index != -1 ? 97 + index : unit;
      }));
    });

    var appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.checkStudentAttendance(_decryptedText).then((value)async{
      if (appProvider.checked.isNotEmpty) {
        await supabase.from('Student_Register_Attendance').insert({
          'Student_ID': CacheHelper.getData(key: 'userId'),
          'Attend_ID': appProvider.checked[0].attendID,
          'code': appProvider.checked[0].code,
          'TimeStamp': DateTime.now().toIso8601String(),
        });

        appProvider.checked = [];
        DialogUtil.showMessage(
          context,
          "Attendance registered successfully",
          posActionTitle: "Ok",
          posAction: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      } else {
        DialogUtil.showMessage(
          context,
          "Please scan the correct QR Code And make sure that you are at the Same Network of the Doctor",
          posActionTitle: "Ok",
          posAction: () {
            Navigator.pop(context);
            Navigator.pop(context);
            cipher = '';
          },
        );
      }
    });
  }

  @override
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _encryptedTextController,
                  decoration: InputDecoration(labelText: 'Enter encrypted text'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: connectToServer,
                  child: Text('Connect'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: decryptText,
                  child: Text('Decrypt'),
                ),
                SizedBox(height: 20),
                Text('ip: $serverAddress'),
                SizedBox(height: 20),
                Text('Decrypted Text: $_decryptedText' , style: TextStyle(fontSize: 20 , color: Colors.black)),
                SizedBox(height: 20),
                Text('Decryption Key: $_decryptionKey' , style: TextStyle(fontSize: 20 , color: Colors.black)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Image(
                image: AssetImage('assets/images/icons/techny-time-management.png'),
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          )

        ],
      ),
    );
  }
}