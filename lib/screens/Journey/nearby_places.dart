import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

// ignore: must_be_immutable
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
                              title:
                                  const CustomText(text: 'Confirm to delete'),
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

                                      // ignore: use_build_context_synchronously
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
                          key: placepageformkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //!
                              Container(
                                width: 40,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color:
                                      const Color.fromARGB(255, 202, 202, 202),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                text: 'Save nearest places',
                                size: 20,
                                color: Colors.black, //!
                                fontweight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: placename,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    hintText: 'Type.. place name',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    suffixIconColor: const Color.fromARGB(
                                        255, 121, 120, 120),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          placename.clear();
                                        },
                                        icon: const Icon(
                                            Icons.restart_alt_rounded)),
                                    labelText: 'Place',
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(
                                            255, 121, 120, 120))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please add place name';
                                  } else if(value.length>18){
                                    return 'name cannot exceed 18 characters.';
                                  }
                                   else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: placedescription,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    suffixIconColor: const Color.fromARGB(
                                        255, 121, 120, 120),
                                    hintText: ' Type... description',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          placedescription.clear();
                                        },
                                        icon: const Icon(
                                            Icons.restart_alt_rounded)),
                                    labelText: 'Description',
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(
                                            255, 121, 120, 120))),
                                validator: (value) {
                                  //!
                                  if (value == null || value.isEmpty) {
                                    return 'please add description';
                                  } else if (value.trim() ==
                                      value.replaceAll(RegExp(r'[^\d]'), '')) {
                                    return 'Description should not only contain numbers.';
                                  } else if(value.length>25){
                                    return 'Description cannot exceed 25 characters.';
                                  }
                                  return null;
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
                                    bottomsheetaddbuttonclicked(placeobj1.key);
                                  }),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CustomText(
                                    text: 'Cancel',
                                    color: Color.fromARGB(255, 101, 100, 100),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).then((value) {
            setState(() {});

            placedescription.clear();
            placename.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: steps.isEmpty
          ? SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('Asset/Image/Add notes-amico.png'),
                    const Text('No places added yet'),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Your place is completed')));
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
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }
}
