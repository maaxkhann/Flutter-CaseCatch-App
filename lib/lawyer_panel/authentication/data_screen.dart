import 'dart:io';

import 'package:catch_case/lawyer_panel/controllers/auth_controller.dart';
import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:velocity_x/velocity_x.dart';

import '../widgets/primary_textfield.dart';
import 'signin_screen.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool loading = false;
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String imageaddress = "";
  String imagetoUpload = "";
  String imageUploaded = "";

  final practices = <String>[
    'Family matters',
    'Corporate buisness',
    'Immigration case',
    'Tax case'
  ];
  final _categories = <String>[
    'Criminal',
    'Family',
    'Labour',
    'Divorce',
    'Civil',
    'Military',
  ];
  String loadingMessage = "Registring User";

  String? _category;
  String? _practice;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  LawyerAuthController authController = Get.put(LawyerAuthController());
  LawyerProfileController profileController =
      Get.put(LawyerProfileController());
  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'Let’s create account toghter',
                  style: TextStyle(
                    color: Color(0xFF828A89),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                20.heightBox,
                Center(
                  child: Obx(
                    () => authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () async {
                              authController.pickImage(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color:
                                      const Color.fromARGB(255, 231, 231, 231),
                                  image: authController.image == null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/lawyer/lawyer.png'))
                                      : DecorationImage(
                                          image: FileImage(
                                            File(authController.image!.path)
                                                .absolute,
                                          ),
                                          fit: BoxFit.cover)),
                            ),
                          ),
                  ),
                ),
                20.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller: nameController,
                        text: 'Enter your name'),
                    10.heightBox,
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: emailController,
                        text: 'Enter your email'),
                    10.heightBox,
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        obsecure: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility,
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                        controller: passwordController,
                        text: 'Enter your password'),
                    10.heightBox,
                    const Text(
                      'Contact',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        controller: contactController,
                        text: 'Enter your contact'),
                    10.heightBox,
                    const Text(
                      'Address',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        controller: addressController,
                        text: 'Enter your address'),
                    10.heightBox,
                    const Text(
                      'Specialization',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        filled: true,
                        fillColor: const Color(0xffEEEEEE),
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.black),
                        hintText: 'Select Specialization',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      value: _category,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      items: _categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    10.heightBox,
                    const Text(
                      'Practice Area',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.030,
                        ),
                        filled: true,
                        fillColor: const Color(0xffEEEEEE),
                        prefixIcon:
                            const Icon(Icons.category, color: Colors.black),
                        hintText: 'Select practice area',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      value: _practice,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a practice area';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _practice = value;
                        });
                      },
                      items: practices
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                    ),
                    10.heightBox,
                    const Text(
                      'Price optional',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        controller: priceController,
                        text: 'Enter your Price '),
                    10.heightBox,
                    const Text(
                      'Experience',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.black,
                        ),
                        controller: experienceController,
                        text: 'Enter your experience'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller: bioController,
                        text: 'Enter your bio'),
                    36.heightBox,
                    Center(
                      child: InkWell(
                        onTap: () async {
                          try {
                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String contact = contactController.text.trim();
                            String price = priceController.text.trim();
                            String date = dateController.text.trim();
                            String address = addressController.text.trim();
                            String password = passwordController.text.trim();
                            String bio = bioController.text.trim();
                            String experience =
                                experienceController.text.trim();

                            if (name.isEmpty ||
                                email.isEmpty ||
                                authController.image == null ||
                                address.isEmpty ||
                                contact.isEmpty ||
                                _categories.isEmpty ||
                                _practice == null ||
                                experience.isEmpty ||
                                bio.isEmpty ||
                                password.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Please enter all details');
                            } else {
                              profileController
                                  .uploadProfile(email, email, imagetoUpload)
                                  .then((value) => imagetoUpload = value);

                              await authController.signUpMethod(
                                  name: name,
                                  contact: contact,
                                  password: password,
                                  email: email,
                                  category: _category.toString(),
                                  practice: _practice.toString(),
                                  address: address,
                                  experience: experience,
                                  bio: bio,
                                  date: date,
                                  context: context,
                                  price: price);
                            }
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 45,
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: loading
                                    ? loadingButtonColor
                                    : defaultButtonColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Visibility(
                                  visible: !loading,
                                  child: const Text(
                                    'Create Account',
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
                ),
                const SizedBox(
                  height: 19,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          color: Color(0xFF828A89),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFFFFC100),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/tick.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  'You have successfully created your lawyer account on Kanoon App. Now complete your KYC to start attending cases.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Future.delayed(const Duration(seconds: 4), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (_) => const DegreeData()));
    // });
  }
}
