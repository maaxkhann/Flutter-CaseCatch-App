
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PdfViewerScreen extends StatefulWidget {
  final String documents;
  final String id;
  const PdfViewerScreen({super.key, required this.documents, required this.id});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
late PDFViewController pdfControllers;
  bool isReady = false;  
  @override
  Widget build(BuildContext context) {
    print(widget.documents);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            44.heightBox,
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: Get.width * .12),
                const Text(
                  'Compare Document',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            10.heightBox,
             Container(
              height: 555,width: 344,
              child:   PDFView(
        filePath: widget.documents,
        // You can also use the asset or network constructors of PDFView
        // asset: "assets/sample.pdf",
        // network: "https://example.com/sample.pdf",
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageSnap: true,
        pageFling: false,
        onRender: (pages) {
          // Do something when rendering is done
        },
        onError: (error) {
          // Handle the error
        },
        onPageError: (page, error) {
          // Handle the page error
        },
        onViewCreated: (PDFViewController pdfViewController) {
          // Do something with the controller
        },
        
      ),
    
                
            ),
          ],
        ),
      ),
    );
  }
}
