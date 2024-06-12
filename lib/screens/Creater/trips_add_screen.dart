import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class AddTripscrren extends StatefulWidget {
  const AddTripscrren({super.key});

  @override
  State<AddTripscrren> createState() => _AddTripscrrenState();
}

class _AddTripscrrenState extends State<AddTripscrren> {
//  final String tripkey = UniqueKey().toString();
  TextEditingController destinationcontroller = TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  DateTime? startingdate;
  DateTime? endingdate;

  final formkey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 10, 60, 92),
      appBar: AppBar(
        title: const Text('Add your trips'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: GestureDetector(
                    onTap: () => uploadImage(),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(179, 190, 190, 190),
                        border:
                            Border.all(color: Colors.black), // Example border
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: _image != null
                          ? kIsWeb // Check if the platform is web
                              ? Image.network(
                                  _image!.path) // Use Image.network for web
                              : Image.file(File(_image!.path),
                                  fit: BoxFit
                                      .cover) // Use Image.file for other platforms
                          : const Icon(Icons.add_photo_alternate, size: 60),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: destinationcontroller,
                  decoration: const InputDecoration(
                      filled: true,
                      suffixIcon: Icon(Icons.location_on_outlined),
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      hintText: 'Destination',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Destination';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: startdatecontroller,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month_sharp),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      hintText: 'Choose Start Date',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter select your Date';
                    }
                    return null;
                  },
                  onTap: () => _selectDate(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: enddatecontroller,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month_sharp),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      hintText: 'Choose End Date',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter select your Date';
                    }
                    return null;
                  },
                  onTap: () => _selectendDate(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: budgetcontroller,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Budget';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.currency_exchange),
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      hintText: 'Budget',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      donebuttonclicked();
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  donebuttonclicked() async {
    String destination = destinationcontroller.text.trim();
    var startdate = startdatecontroller.text.trim();
    var enddate = enddatecontroller.text.trim();
    var budget = budgetcontroller.text.trim();
    var image = _image?.path;
    if (destination.isNotEmpty &&
        startdate.isNotEmpty &&
        enddate.isNotEmpty &&
        budget.isNotEmpty) {
      if (formkey.currentState!.validate()) {
        // final tripbox = Hive.box('tripdbbox');
        final newtrip = Tripmodel(
            destination: destination,
            startdate: startingdate!,
            enddate: endingdate!,
            budget: int.parse(budget),
            image: image);
        await Tripdb().addData(newtrip).then((value) {
          Navigator.pop(context, true);
          Navigator.pop(context, true);
        });
      }
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      startingdate = picked;
      setState(() {
        startdatecontroller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectendDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      endingdate = picked;
      setState(() {
        enddatecontroller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> uploadImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }
}
