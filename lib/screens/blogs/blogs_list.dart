import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/screens/blogs/add_blog_screen.dart';
import 'package:travelapp/screens/Creater/blog_edit_page.dart';
import 'package:travelapp/screens/blogs/single_blog_view.dart';

class Blogslist extends StatefulWidget {
  // BlogModal? bloglistobj;
  const Blogslist({
    super.key,
  });

  @override
  State<Blogslist> createState() => _BlogslistState();
}

class _BlogslistState extends State<Blogslist> {
  // late BlogModal objblog;
  @override
  void initState() {
    
    BlogDbFunc().allblog();
    // objblog = widget.bloglistobj;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){ Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddBlogpage()));},child:const Icon(Icons.add) ,),
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
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(5)),
                                              child: kIsWeb?
                                              Image.network(
                                                bloglist[index].blogImage,
                                                fit: BoxFit.fill,
                                              ):
                                              Image.file(
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
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: const CustomText(
                                                                    text:
                                                                        'Confirm to delete'),
                                                                content: const CustomText(
                                                                    text:
                                                                        'Are you sure ,you wanted to delete this trip'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child: const CustomText(
                                                                          text:
                                                                              'No')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        BlogDbFunc()
                                                                            .deleteblog(bloglist[index].key);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const CustomText(
                                                                          text:
                                                                              'Yes'))
                                                                ],
                                                              ));
                                                  //
                                                },
                                                value: 'option1',
                                                child: const Text('Delete'),
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
                                                child: const Text('Edit'),
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
                          const Text('No Data Found'),
                        ],
                      );
              }),
        ],
      ),
    );
  }
}
