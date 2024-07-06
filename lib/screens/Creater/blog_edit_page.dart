import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/db/db_model/blog_modal.dart';

class EditBlogpage extends StatefulWidget {
  final BlogModal editBlogObj;
  const EditBlogpage({super.key, required this.editBlogObj});

  @override
  State<EditBlogpage> createState() => _EditBlogpageState();
}

class _EditBlogpageState extends State<EditBlogpage> {
  final ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> editBlogformkey = GlobalKey<FormState>();
  late BlogModal objEditBlog;
  late TextEditingController editBlogTitle;
  late TextEditingController editBlogContent;
  late XFile editimage;
  @override
  void initState() {
    
    objEditBlog = widget.editBlogObj;
    editBlogContent =
        TextEditingController(text: widget.editBlogObj.blogContent);
    editBlogTitle = TextEditingController(text: widget.editBlogObj.blogTitle);
    editimage = XFile(widget.editBlogObj.blogImage);
    super.initState();
  }

  Widget build(BuildContext context) {
    // bool _isFocused = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your blogs'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: () => blogUpdate(objEditBlog.key),
              child: CustomText(
                text: 'Update',
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: editBlogformkey,
            child: Column(
              children: [
                TextFormField(
                  controller: editBlogTitle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: 'Title', hintText: '--give a title--'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'give your contents';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () => uploadImage(),
                    child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            // color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: editimage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(9.5),
                                child: Image.file(
                                  File(
                                    editimage.path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SizedBox())), //!RETURNING SIZEDBOX

                SizedBox(
                  height: 20,
                ),
                
                TextFormField(
                  controller: editBlogContent,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // focusNode: _focusNode,
                  maxLines: 100,
                  // _isFocused ? 5 : 1, // Increase maxLines when focused
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'give your contents';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      editimage = pickedFile!;
    });
  }

  blogUpdate(key) async {
    var title = editBlogTitle.text.trim();
    var content = editBlogContent.text.trim();
    var image = editimage.path ??'';
    if (title.isNotEmpty && content.isNotEmpty&&image.isNotEmpty) {
      if (editBlogformkey.currentState!.validate()) {
        final blogKit = BlogModal(
            blogTitle: title, blogImage: image, blogContent: content); 
        await BlogDbFunc().editBlog(key, blogKit);
        setState(() {
          
        });
       
        Navigator.pop(context);
        
      }
    }
  }
}
