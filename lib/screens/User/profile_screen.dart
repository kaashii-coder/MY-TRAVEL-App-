import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_container.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    Tripdb().getAll();
    BlogDbFunc().allblog();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Profile',
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('8330836077'),
                      SizedBox(
                        width: 130,
                      ),
                      Icon(Icons.edit)
                    ],
                  ),
                  Text('Member Since April ,2024')
                ],
              )
            ]),
            const SizedBox(
              height: 25,
            ),
            const Divider(),
            const CustomText(
              text: 'My Journey',
              color: Colors.black,
              fontweight: FontWeight.w700,
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
                    leading: Text('My Blogs', style: TextStyle(fontSize: 13)),
                    trailing: Text(blogNotifier.value.length.toString(), style: TextStyle(fontSize: 13)),
                  ),
                  const ListTile(
                    leading: Text('My spends', style: TextStyle(fontSize: 13)),
                    trailing: Text('0', style: TextStyle(fontSize: 13)),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }
}
