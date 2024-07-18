import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

// ignore: must_be_immutable
class EditTripscrren extends StatefulWidget {
  Tripmodel editTrip;
  EditTripscrren({super.key, required this.editTrip});

  @override
  State<EditTripscrren> createState() => _EditTripscrrenState();
}

class _EditTripscrrenState extends State<EditTripscrren> {
  late Tripmodel editTripobj;
//  final String tripkey = UniqueKey().toString();
  late TextEditingController editDestinationcontroller;
  late TextEditingController editStartdatecontroller;
  late TextEditingController editEnddatecontroller;
  late TextEditingController editBudgetcontroller;
  DateTime? startingdate;
  DateTime? endingdate;

  final editformkey = GlobalKey<FormState>();
  late XFile editImage;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
 
    super.initState();
    log(widget.editTrip.key.toString());
    editTripobj = widget.editTrip;
    editBudgetcontroller =
        TextEditingController(text: widget.editTrip.budget.toString());
    editDestinationcontroller =
        TextEditingController(text: widget.editTrip.destination);
    editStartdatecontroller =
        TextEditingController(text: widget.editTrip.startdate.toString());
    editEnddatecontroller =
        TextEditingController(text: widget.editTrip.enddate.toString());
    editImage = XFile(widget.editTrip.image ?? '');
    startingdate = widget.editTrip.startdate;
    endingdate = widget.editTrip.enddate;
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your trips'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: editformkey,
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
                      // ignore: unnecessary_null_comparison
                      child: editImage != null
                          ? kIsWeb
                              ? Image.network(editImage.path)
                              : Image.file(File(editImage.path),
                                  fit: BoxFit.cover)
                          : const Icon(Icons.add_photo_alternate, size: 60),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: editDestinationcontroller,
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
                  controller: editStartdatecontroller,
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
                  controller: editEnddatecontroller,
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
                  controller: editBudgetcontroller,
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
                      donebuttonclicked(widget.editTrip.key);
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

  donebuttonclicked(dynamic key) async {
    log(key.toString());
    String destination = editDestinationcontroller.text.trim();
    var startdate = editStartdatecontroller.text.trim();
    var enddate = editEnddatecontroller.text.trim();
    var budget = editBudgetcontroller.text.trim();
    var image = editImage.path;
    if (destination.isNotEmpty &&
        startdate.isNotEmpty &&
        enddate.isNotEmpty &&
        budget.isNotEmpty) {
      if (editformkey.currentState!.validate()) {
        // final tripbox = Hive.box('tripdbbox');
        editTripobj.destination = destination;
        editTripobj.startdate = startingdate!;
        editTripobj.enddate = endingdate!;
        editTripobj.budget = int.parse(budget);
        editTripobj.image = image;
       
        Tripdb()
            .editDetails(editTripobj, key)
            .then((value) => Navigator.pop(context));
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
        editStartdatecontroller.text = picked.toString().split(" ")[0];
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
        editEnddatecontroller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> uploadImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      editImage = pickedFile!;
    });
  }
}
