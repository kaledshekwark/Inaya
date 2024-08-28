import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle; // For accessing assets
import 'package:flutter/foundation.dart';

class MomeanBook extends StatefulWidget {
 const MomeanBook({super.key});

 @override
 State<MomeanBook> createState() => _MomeanBookState();
}

class _MomeanBookState extends State<MomeanBook> {
 late Future<File> pdfFile;
 var currentPage = 0;

 @override
 void initState() {
  super.initState();
  pdfFile = getPdfFile();
 }

 Future<File> getPdfFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/momean_book.pdf';
  final file = File(filePath);

  if (await file.exists()) {
   return file;
  } else {
   return DownloadService.copyAssetPdfToFile('assets/pdf/momean_book.pdf');
  }
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   backgroundColor: Colors.white,
   body: FutureBuilder<File>(
    future: pdfFile,
    builder: (context, snapshot) {
     return SizedBox(
      height: Get.height - 100,
      width: Get.width,
      child: snapshot.hasData
          ? PdfThumbnail.fromFile(
       scrollToCurrentPage: false,
       snapshot.data!.path,
       height: Get.height - 100,
       currentPage: currentPage,
       backgroundColor: Colors.white,
       currentPageWidget: (page, isCurrentPage) {
        return Positioned(
         bottom: 0,
         right: 0,
         child: Container(
          height: 40,
          width: 30,
          color: isCurrentPage ? Colors.green : Colors.pink,
          alignment: Alignment.center,
          child: Text(
           '$page',
           style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
           ),
          ),
         ),
        );
       },
       currentPageDecoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
         bottom: BorderSide(
          color: Colors.orange,
          width: 10,
         ),
        ),
       ),
       onPageClicked: (page) {
        setState(() {
         currentPage = page + 1;
        });
        if (kDebugMode) {
         print('Page $page clicked');
        }
       },
      )
          : const CircularProgressIndicator(),
     );
    },
   ),
  );
 }
}

class DownloadService {
 static Future<File> copyAssetPdfToFile(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final buffer = byteData.buffer;

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/${assetPath.split('/').last}';
  final file = File(filePath);

  await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
 }
}
