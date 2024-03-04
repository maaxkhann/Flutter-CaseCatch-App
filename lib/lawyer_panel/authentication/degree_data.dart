import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/degree_controller.dart';

class DegreeData extends StatefulWidget {
  const DegreeData({super.key});

  @override
  State<DegreeData> createState() => _DegreeDataState();
}

class _DegreeDataState extends State<DegreeData> {
  TextEditingController addressController = TextEditingController();
  TextEditingController clgnameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  DegreeController controller = Get.put(DegreeController());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // const Color defaultButtonColor = Colors.amber;
    // const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  ],
                ),
                40.heightBox,
                const Text(
                  'Lawyer College Degree',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                20.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Institution Name',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: clgnameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "The Best Law College Rawalpindi",
                        focusColor: Colors.green,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.school,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Insitution Name';
                        }
                        return null;
                      },
                    ),
                    10.heightBox,
                    const Text(
                      'Institution Address',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: addressController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black, // Change border color
                          ),
                        ),
                        hintText: "The Best LAw College Rawalpindi, A Block",
                        focusColor: Colors.green,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Institution Address';
                        }
                        return null;
                      },
                    ),
                    10.heightBox,
                    const Text(
                      'Degree',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: degreeController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black, // Change border color
                          ),
                        ),
                        hintText: "Bachelor of laws (LLB)",
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.book,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Degree';
                        }
                        return null;
                      },
                    ),
                    10.heightBox,
                    const Text(
                      'Batch year',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: batchController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black, // Change border color
                          ),
                        ),
                        hintText: "2008",
                        focusColor: Colors.black,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Batch Year';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'Upload Degree Documents',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'JPEG, PNG, PDF (min 4Mb - max 8Mb)',
                      style: TextStyle(
                        color: Color(0xFFB8B8B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Obx(
                      () => Container(
                        width: Get.size.width,
                        height: 49,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 14),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: controller.pdfUrl.value == ""
                              ? null
                              : Colors.amber,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFABABAB)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isPdfUploading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.pdfUrl.value == ""
                                ? InkWell(
                                    onTap: () {
                                      controller.pickPDF();
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Upload Document',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFFC100),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.pdfUrl.value = "";
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "Delete Pdf",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      ),
                    ),
                    50.heightBox,
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (clgnameController.text == "" ||
                              addressController.text == "" ||
                              degreeController.text == "" ||
                              batchController.text == "") {
                            Fluttertoast.showToast(
                                msg: "Some of Fields are empty");
                          } else {
                            await controller.addDegreeData(
                              batchController.text,
                              clgnameController.text,
                              degreeController.text,
                              addressController.text,
                            );
                          }
                          // Get.to(() => const OfficeAddress());
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 349 * 12,
                              decoration: BoxDecoration(
                                color: loading ? Colors.grey : Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Center(
                                child: Visibility(
                                  visible: !loading,
                                  child: const Text(
                                    'Continue',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (loading)
                              const Positioned.fill(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
