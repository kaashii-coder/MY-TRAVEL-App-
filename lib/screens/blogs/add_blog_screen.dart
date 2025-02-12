import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/blog_function.dart';
import 'package:travelapp/db/db_model/blog_modal.dart';

class AddBlogpage extends StatefulWidget {
  const AddBlogpage({super.key});

  @override
  State<AddBlogpage> createState() => _AddBlogpageState();
}

class _AddBlogpageState extends State<AddBlogpage> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageObj;
  GlobalKey<FormState> blogformkey = GlobalKey<FormState>();
  final TextEditingController blogTitle = TextEditingController();
  final TextEditingController blogContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
   // bool _isFocused = false;
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text:'Add new blogs',color: Colors.white,),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: () => blogsave(),
              child: const CustomText(
                text: 'save',
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: blogformkey,
            child: Column(
              children: [
                TextFormField(
                  controller: blogTitle,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'Title', hintText: '--give a title--'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'give your contents';
                    }
                    return null;
                  },
                ),
                const SizedBox(
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
                        child: imageObj != null
                            ?kIsWeb?
                            ClipRRect(
                                borderRadius: BorderRadius.circular(9.5),
                                child: Image.network(
                                  
                                    imageObj!.path,
                                  
                                  fit: BoxFit.cover,
                                ),
                              ): 
                            ClipRRect(
                                borderRadius: BorderRadius.circular(9.5),
                                child: Image.file(
                                  File(
                                    imageObj!.path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.add_photo_alternate, size: 60),)), //!RETURNING SIZEDBOX

                const SizedBox(
                  height: 20,
                ),
                
                TextFormField(
                  controller: blogContent,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // focusNode: _focusNode,
                  maxLines:50,
                      // _isFocused ? 5 : 1, // Increase maxLines when focused
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                   // labelText: 'Enter text',
                    hintText: 'Enter your text'
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
      imageObj = pickedFile;
    });
  }

  blogsave() async {
    var title = blogTitle.text.trim();
    var content = blogContent.text.trim();
    var image = imageObj?.path.toString();
    
    if (title.isNotEmpty && content.isNotEmpty) {
      if (blogformkey.currentState!.validate()) {
        final blogKit = BlogModal(
            blogTitle: title, blogImage: image!, blogContent: content);
        await BlogDbFunc().blogAdd(blogKit);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        
      }
    }
  }
}
