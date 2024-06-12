import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_model/blog_modal.dart';

class SingleBlogView extends StatefulWidget {
  final BlogModal blogviewobj;
  const SingleBlogView({super.key, required this.blogviewobj});

  @override
  State<SingleBlogView> createState() => _SingleBlogViewState();
}

class _SingleBlogViewState extends State<SingleBlogView> {
  late BlogModal blogView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     blogView = widget.blogviewobj;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Destinoozz'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomText(text:blogView.blogTitle,size: 20,),
            SizedBox(height: 10,),
            SizedBox(height: 200,width: double.infinity,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.file(File(blogView.blogImage),fit: BoxFit.fill,))),
            SizedBox(height: 10,),
            CustomText(text: blogView.blogContent)
          ],
        ),
      ),
    );
  }
}
