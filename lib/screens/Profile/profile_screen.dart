import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_container.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_function/userdb_functions.dart';
import 'package:travelapp/db/db_model/user_model.dart';
import 'package:travelapp/screens/Profile/contact_details.dart';
import 'package:travelapp/screens/Profile/privacy_policy.dart';
import 'package:travelapp/screens/Profile/terms_and_services.dart';

class ProfileScreen extends StatefulWidget {
  
 
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // XFile? _image;
  // final ImagePicker _picker = ImagePicker();
//  final Usermodel userdata= ;
  @override
  void initState() {
    Tripdb().getAll();
    BlogDbFunc().allblog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const CustomText(
          text: 'Profile',
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                  valueListenable: usernotifier,
                  builder: (context, list, _) {
                    return Row(children: [
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CustomContainer(
                            // width: 65,
                            // height: 65,
                            color: const Color.fromARGB(202, 195, 192, 192),
                            onTap: () {},
                            child: const Icon(
                              Icons.person,
                              size: 45,
                              color: Color.fromARGB(121, 120, 92, 92),
                            )),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('User'),
                              SizedBox(
                                width: 130,
                              ),
                              // Icon(Icons.edit)
                            ],
                          ),
                          Text('Member Since 2024')
                        ],
                      )
                    ]);
                  }),
              const SizedBox(
                height: 25,
              ),
              const Divider(
                color: Colors.black54,
              ),
              const CustomText(
                text: 'My Journey',
                color: Colors.black,
                fontweight: FontWeight.w700,
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                  child: SizedBox(
                height: 169,
                width: 150,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Text(
                        'My trips',
                        style: TextStyle(fontSize: 13),
                      ),
                      trailing: Text(tripnotifier.value.length.toString()),
                    ),
                    ListTile(
                      leading: const Text('My Blogs',
                          style: TextStyle(fontSize: 13)),
                      trailing: Text(blogNotifier.value.length.toString(),
                          style: const TextStyle(fontSize: 13)),
                    ),
                    const ListTile(
                      leading:
                          Text('My spends', style: TextStyle(fontSize: 13)),
                      trailing: Text('0', style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              )),
              const Divider(
                thickness: .5,
                color: Colors.black,
              ),
              const CustomText(
                text: 'My Account and support',
                color: Colors.black,
                fontweight: FontWeight.w700,
              ),
              const SizedBox(
                height: 15,
              ),
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                  ),
                  title: CustomText(text: 'Settings'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactPage()));
                  },
                  leading: const Icon(
                    Icons.headset_mic_rounded,
                  ),
                  title: const CustomText(text: 'Contact Support'),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage()));
                  },
                  leading: const Icon(Icons.lock_outline_rounded),
                  title: const CustomText(text: 'Privacy Plolicy'),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndServices()));
                  },
                  leading: const Icon(
                    Icons.library_books,
                  ),
                  title: const CustomText(text: 'Terms Of service'),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.star_border_purple500_outlined,
                  ),
                  title: CustomText(text: 'Rate Us'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'App version 2.0',
                    size: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> uploadImage() async {
  //   var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = pickedFile;
  //   });
  // }
}
