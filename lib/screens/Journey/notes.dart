import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_card.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class JourneynotesPage extends StatefulWidget {
  final Tripmodel data;
  JourneynotesPage({super.key, required this.data});

  @override
  State<JourneynotesPage> createState() => _JourneynotesPageState();
}

class _JourneynotesPageState extends State<JourneynotesPage> {
  late Tripmodel notesDatas;
  final TextEditingController noteHead = TextEditingController();
  final TextEditingController noteDesctription = TextEditingController();
  final GlobalKey<FormState> noteFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesDatas = widget.data;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Container(
                        //!
                        height: 360,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: Form(
                            //!
                            key: noteFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              
                              children: [
                                //!
                                Container(
                                  width: 40,
                                  height: 6.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.5),
                                    color: Color.fromARGB(255, 202, 202, 202),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                  text: 'Save your notes',
                                  size: 20,
                                  color: Colors.black, //!
                                  fontweight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: noteHead,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      hintText: ' type... title',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                      suffixIconColor:
                                          Color.fromARGB(255, 121, 120, 120),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            noteHead.clear();
                                          },
                                          icon:
                                              Icon(Icons.restart_alt_rounded)),
                                      labelText: 'Title',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 121, 120, 120))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please add note title';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  controller: noteDesctription,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                      suffixIconColor:
                                          Color.fromARGB(255, 121, 120, 120),
                                      hintText: ' type... description',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            noteDesctription.clear();
                                          },
                                          icon:
                                              Icon(Icons.restart_alt_rounded)),
                                      labelText: 'Description',
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 121, 120, 120))),
                                  validator: (value) {
                                    //!
                                    if (value == null || value.isEmpty) {
                                      return 'please add your description';
                                    } else if (value.trim() ==
                                        value.replaceAll(
                                            RegExp(r'[^\d]'), '')) {
                                      return 'Description should not only contain numbers.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: const CustomText(
                                      color: Colors.white,
                                      text: 'Save',
                                    ),
                                    onPressed: () {
                                      notesAddButtonclicked(notesDatas.key);
                                      
                                    }),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomText(
                                      text: 'Cancel',
                                      color: const Color.fromARGB(
                                          255, 101, 100, 100),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notesDatas.notesModal?.length ?? 0,
                itemBuilder: (context, index) {
                  return CustomCard(colorIndex: index, data: notesDatas);
                },
              ),
            )
          ],
        ));
  }

  notesAddButtonclicked(var key) async {
    String titleText = noteHead.text.trim();
    String notesDescription = noteDesctription.text.trim();
    if (noteFormKey.currentState!.validate()) {
      if (titleText.isNotEmpty && notesDescription.isNotEmpty) {
        final notesCarrier =
            NotesModal(title: titleText, description: notesDescription);
        notesDatas.notesModal == null
            ? notesDatas.notesModal = [notesCarrier]
            : notesDatas.notesModal!.add(notesCarrier);
        await Tripdb().addnearbyplaces(notesDatas, key);

        Navigator.pop(context);
        setState(() {
          noteHead.clear();
          noteDesctription.clear();
        });
      }
    }
  }
}
