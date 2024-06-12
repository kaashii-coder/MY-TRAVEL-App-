import 'dart:io';

import 'package:flutter/material.dart';

import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/screens/Creater/blog_edit_page.dart';
import 'package:travelapp/screens/blogs/single_blog_view.dart';

class Blogslist extends StatefulWidget {
  // BlogModal? bloglistobj;
  Blogslist({
    super.key,
  });

  @override
  State<Blogslist> createState() => _BlogslistState();
}

class _BlogslistState extends State<Blogslist> {
  // late BlogModal objblog;
  @override
  void initState() {
    // TODO: implement initState
    BlogDbFunc().allblog();
    // objblog = widget.bloglistobj;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Blogs',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: blogNotifier,
              builder: (BuildContext context, bloglist, _) {
                return bloglist.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: bloglist.length,
                            itemBuilder: (context, index) {
                              // log(bloglist[index].blogTitle);
                              final passData = bloglist[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SingleBlogView(
                                            blogviewobj: passData,
                                          ),
                                        ));
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              child: Image.file(
                                                File(bloglist[index].blogImage),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        ListTile(
                                          title: CustomText(
                                              text:
                                                  'Review: ${bloglist[index].blogTitle}'),
                                          trailing: PopupMenuButton<String>(
                                            onSelected: (String value) {},
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry<String>>[
                                              PopupMenuItem<String>(
                                                onTap: () {
                                                  BlogDbFunc().deleteblog(
                                                      bloglist[index].key);
                                                },
                                                value: 'option1',
                                                child: Text('Delete'),
                                              ),
                                              PopupMenuItem<String>(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditBlogpage(
                                                                  editBlogObj:
                                                                      bloglist[
                                                                          index])));
                                                },
                                                value: 'option2',
                                                child: Text('Edit'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Column(
                        children: [
                          Image.asset('Asset/Image/Add notes-amico.png'),
                          Text('No Data Found'),
                        ],
                      );
              }),
        ],
      ),
    );
  }
}
