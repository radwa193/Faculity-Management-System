import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeFunctions {
  static dynamic scanQrCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#2A99CF',
          'Cancel',
          true,
          ScanMode.QR
      );
      print(qrCode);
      return qrCode;
    } catch (e) {
      print(e.toString());
    }
  }

  static Widget showQrCode(Uint8List? data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BarcodeWidget(
          color: Color(0xFF2A99CF),
          barcode: Barcode.qrCode(),
          data: data != null ? data.toString() : 'No data',
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}
