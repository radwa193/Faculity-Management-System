import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrCodeFunctions {
  static void scanQrCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#2A99CF',
          'Cancel',
          true,
          ScanMode.QR
      );
      print(qrCode);
    } catch (e) {
      print(e.toString());
    }
  }

  static Widget showQrCode() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BarcodeWidget(
              color: const Color(0xFFEF7505),
              barcode: Barcode.qrCode(),
              data: 'https://o6u.edu.eg/',
              width: 400.w,
              height: 400.h,
            ),
             SizedBox(height: 150.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  color: const Color(0xFFEF7505),
                  child: const Text('Finish'),
                  onPressed: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
