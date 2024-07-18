// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/userdb_functions.dart';
import 'package:travelapp/db/db_model/user_model.dart';
import 'package:travelapp/screens/Intro/home_pages_main.dart';

class ProfileCreateScreen extends StatefulWidget {
  const ProfileCreateScreen({super.key});

  @override
  State<ProfileCreateScreen> createState() => _ProfileCreateScreen();
}

class _ProfileCreateScreen extends State<ProfileCreateScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool ischeckedbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text(
          'Create Your Profile',
          style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          focusColor: Colors.blue,
                          filled: true,
                          prefixIcon: const Icon(Icons.person),
                          fillColor: Colors.white,
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please add your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.email_outlined),
                          fillColor: Colors.white,
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please add your Email';
                          // } else if (!value.contains('@')) {
                          //   return 'Please enter a valid email address';
                        } else if (!value.contains('@gmail.com'))
                          return 'Please enter a valid email address';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: addressController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Address/city',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'give your city/address';
                        }
                        return null;
                        // if (value!.isEmpty) {
                        //   return 'please add your password';
                        // } else if (value.length < 8) {
                        //   return 'please enter minimum 8 characters';
                        // } else if (!value.contains(RegExp(r'[A-Z]')) ||
                        //     ! value.contains(RegExp(r'[a-z]'))) {
                        //   return 'Password must contain both uppercase and lowercase letters';
                        // }
                        // return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          fillColor: Colors.white,
                          labelText: 'Age',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please add your age';
                        } else if (value.length > 2) {
                          return 'please add right values';
                        } else if (value.contains('-')) {
                          return 'please add right values';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: ischeckedbox,
                          onChanged: (value) {
                            setState(() {
                              ischeckedbox = value!;
                            });
                          },
                        ),
                        const CustomText(
                            text: 'Accept the terms and coditions'),
                        // TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: ((context) =>
                        //                   const TermsAndConditionsPage())));
                        //     },
                        //     child: const CustomText(text: 'more>'))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        width: double.infinity,
                        child: const Text(' Create '),
                        onPressed: () {
                          createButtonClick();
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text('Already signup?',
                    //         style: TextStyle(color: Color.fromARGB(232, 0, 0, 0))),
                    //     TextButton(
                    //         onPressed: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: ((context) => const LoginScreen())));
                    //         },
                    //         child: const Text(
                    //           'Login',
                    //         ))
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  createButtonClick() async {
    String name = nameController.toString().trim();
    String email = emailController.toString().trim();
    String address = addressController.toString().trim();
    String age = ageController.toString().trim();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        address.isNotEmpty &&
        age.isNotEmpty) {
      if (_formKey1.currentState!.validate()) {
        if (ischeckedbox == true) {
          final user =
              Usermodel(name: name, city: address, email: email, age: age);
          await Userdb().adduser(user).then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) =>  const MyHomePage())));
          });
           await setsharedpreference();
        }
      }
    }
  }
   Future setsharedpreference() async {
    final preference = await SharedPreferences.getInstance();
    preference.setString("My Value", 'true');
  }
}
