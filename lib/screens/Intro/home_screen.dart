import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Tripdb().getAll();
    BlogDbFunc().allblog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: 'DestinoZz',
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                title: const CustomText(
                  text: 'Explore the trips',
                  color: Colors.black,
                  size: 22,
                ),
                subtitle: const CustomText(
                  text: 'Select your next spot',
                  color: Colors.grey,
                  size: 18,
                ),
                trailing: TextButton(
                    child: const CustomText(
                      text: 'See more>>',
                      color: Color.fromARGB(255, 206, 81, 81),
                      size: 16,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: CustomText(
                              text:
                                  'if you want to see more about your trips click bottom second button',
                            ),
                          );
                        }
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyJourneyScreen()));
                    }),
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ValueListenableBuilder(
                    valueListenable: tripnotifier,
                    builder: (context, homelist, _) {
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homelist.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemBuilder: (context, index) {
                            return homelist[index].image == null
                                ? Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.asset(
                                            'Asset/Image/WhatsApp Image 2024-04-29 at 12.24.29_1a26d094.jpg',
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                : Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.file(
                                          File(homelist[index].image!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                          });
                    }),
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                title: const CustomText(
                  text: 'Explore the blogs',
                  color: Colors.black,
                  size: 22,
                ),
                subtitle: const CustomText(
                  text: 'Select your next writing',
                  color: Colors.grey,
                  size: 18,
                ),
                trailing: TextButton(
                    child: const CustomText(
                      text: 'See more>>',
                      color: Color.fromARGB(255, 206, 81, 81),
                      size: 16,
                    ),
                    onPressed: () {
                       showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(backgroundColor: Colors.blue,
                            content: CustomText(
                              text:
                                  'if you want to see more about your blogs click bottom forth button',color: Colors.white,
                            ),
                          );
                        }
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyJourneyScreen()));
                    }),
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ValueListenableBuilder(
                    valueListenable: blogNotifier,
                    builder: (context, homeBlogList, _) {
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeBlogList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemBuilder: (context, index) {
                            return homeBlogList[index].blogImage == null
                                ? Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.asset(
                                            'Asset/Image/WhatsApp Image 2024-04-29 at 12.24.29_1a26d094.jpg',
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                : Card(
                                    child: SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.file(
                                          File(homeBlogList[index].blogImage),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                          });
                    }),
              ),
            ],
          ),
        ));
  }
}
