import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

// ignore: must_be_immutable
class JourneyPhotosPage extends StatefulWidget {
  Tripmodel tripmodelobj;
  JourneyPhotosPage({required this.tripmodelobj, super.key});

  @override
  State<JourneyPhotosPage> createState() => _JourneyPhotosPageState();
}

class _JourneyPhotosPageState extends State<JourneyPhotosPage> {
  late Tripmodel tripmodelobj;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    tripmodelobj = widget.tripmodelobj;
  }

  final ImagePicker imagemultipicker = ImagePicker();
  List<XFile>? imagepool;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 40, left: 40),
          child: CustomButton(
              width: double.infinity,
              child: CustomText(text: 'Upload photos'),
              onPressed: () {
                uploadmultiphotos(tripmodelobj.key);
              }),
          decoration: BoxDecoration(),
        ),
         tripmodelobj.tripDetail?.tripphotos==null?
         SizedBox():
        Expanded(
          child: GridView.builder(
            
              itemCount: tripmodelobj.tripDetail!.tripphotos?.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                   final image= tripmodelobj.tripDetail!.tripphotos![index];
                return Card(
                  color: Colors.amber,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                     child: Image.file(File(image)),
                  ),
                );
              }),
        ),
      ],
    );
  }

  uploadmultiphotos(key) async {
    var pickedfiles = await imagemultipicker.pickMultiImage();
    if (pickedfiles.isNotEmpty) {
      List<String> images = [];
      pickedfiles.forEach((element) {
        images.add(element.path);
      });

      for (var image in images) {
        var tripDetailobj = TripDetail(tripphotos: images);
        tripmodelobj.tripDetail?.tripphotos == null
            ? tripmodelobj.tripDetail?.tripphotos = [image]
            : tripmodelobj.tripDetail?.tripphotos!.add(image);

        await Tripdb().addnearbyplaces(tripmodelobj, key);
      }
    }
  }
}
