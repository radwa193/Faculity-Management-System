import 'dart:io';
import 'package:excel/excel.dart';

void excelSheet() {
  // Create Excel file
  var excel = Excel.createExcel();

  // Add a worksheet
  var sheet = excel['Sheet1'];

  // Data to write to Excel
  var data = [
    ['Name', 'Age', 'Country'],
    ['John', 30, 'USA'],
    ['Alice', 25, 'Canada'],
    ['Bob', 35, 'UK'],
  ];

  // Write data to Excel
  for (var row in data) {
    sheet.appendRow(row.cast<CellValue?>());  // Directly passing the list
  }

  // Save Excel file
  var bytes = excel.encode()!;  // Encode the Excel to bytes
  var file = File('output.xlsx');
  file.writeAsBytesSync(bytes);  // Save the bytes to a file
  print('Excel file created!');
}
