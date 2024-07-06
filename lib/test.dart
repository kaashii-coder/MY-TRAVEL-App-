import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class NearbyPlaceaddPage extends StatefulWidget {
  Tripmodel placeobj;
  NearbyPlaceaddPage({
    super.key,
    required this.placeobj,
  });

  @override
  State<NearbyPlaceaddPage> createState() => NearbyPlaceaddPageState();
}

class NearbyPlaceaddPageState extends State<NearbyPlaceaddPage> {
  late Tripmodel placeobj1;
  final GlobalKey<FormState> placepageformkey = GlobalKey<FormState>();
  final TextEditingController placename = TextEditingController();
  final TextEditingController placedescription = TextEditingController();
  List<Step> steps = [];
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeobj1 = widget.placeobj;
  }

  @override
  Widget build(BuildContext context) {
    steps.clear();

    placeobj1.nearbyPlacemodal?.forEach((element) {
      steps.add(Step(
          title: Text(element.placename),
          content: Row(
            children: [
              Text(element.description ?? ''),
              const SizedBox(
                width: 100,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const CustomText(text: 'Confirm to delete'),
                              content: const CustomText(
                                  text:
                                      'Are you sure ,you wanted to delete this trip'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const CustomText(text: 'No')),
                                TextButton(
                                    onPressed: () async {
                                      placeobj1.nearbyPlacemodal
                                          ?.remove(element);
                                      await Tripdb().editDetails(
                                          placeobj1, placeobj1.key);

                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const CustomText(text: 'Yes'))
                              ],
                            ));
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )));
    });
    if (_index >= steps.length) {
      _index = steps.length - 1;
    } else if (_index < 0) {
      _index = 0;
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        child: Container(
                          height: 320,
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 30),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              color: Color.fromARGB(255, 0, 117, 212)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: placepageformkey,
                              child: SingleChildScrollView(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CustomText(
                                        text: 'Add place want to visit',
                                        size: 20,
                                        color: Colors.white),
                                    TextFormField(
                                      controller: placename,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                          labelText: 'Place name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          suffixIcon: Icon(Icons.place)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please add your Place';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: placedescription,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                          labelText: 'Description',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          suffixIcon:
                                              Icon(Icons.description_outlined)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please add your Description';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomButton(
                                        color: Colors.white,
                                        child: const CustomText(text: 'Add'),
                                        onPressed: () {
                                          bottomsheetaddbuttonclicked(
                                              placeobj1.key);
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    ).then((value) {
              setState(() {
               
              });
              placedescription.clear();
              placename.clear();
            });

            
          },
          child: const Icon(Icons.add),
        ),
        body:steps.isEmpty? const Center(
          child:  
             CustomText(text: 'No places added yet.') )
           :SingleChildScrollView(
             child: Column(
               children: [
                 Stepper(
                  key: ValueKey('key ${steps.length}'),
                  currentStep: _index,
                  onStepCancel: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_index < steps.length - 1) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: steps,
                           ),
               ],
             ),
           ),
        );
  }

  bottomsheetaddbuttonclicked(dynamic key) async {
    final placeName = placename.text.trim();
    final placeDetail = placedescription.text.trim();

    if (placepageformkey.currentState!.validate()) {
      if (placeName.isNotEmpty && placeDetail.isNotEmpty) {
        final newplace = NearbyPlacemodal(
            description: placedescription.text, placename: placename.text);
        placeobj1.nearbyPlacemodal == null
            ? placeobj1.nearbyPlacemodal = [newplace]
            : placeobj1.nearbyPlacemodal!.add(newplace);

        await Tripdb().addnearbyplaces(placeobj1, key);
        Navigator.pop(context);
      }
    }
  }
}
