import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
import 'package:hive/hive.dart';

class JourneyPhotosPage extends StatefulWidget {
  final Tripmodel tripmodelobj;
  JourneyPhotosPage({required this.tripmodelobj, Key? key}) : super(key: key);

  @override
  State<JourneyPhotosPage> createState() => _JourneyPhotosPageState();
}

class _JourneyPhotosPageState extends State<JourneyPhotosPage> {
  late Tripmodel tripmodelobj;
  final ImagePicker imagemultipicker = ImagePicker();
  late Box<Tripmodel> tripBox;

  @override
  void initState() {
    super.initState();
    tripmodelobj = widget.tripmodelobj;
    if (tripmodelobj.tripDetail?.tripphotos == null) {
      tripmodelobj.tripDetail?.tripphotos = [];
    }
    openBox();
  }

  @override
  void dispose() {
    tripBox.close();
    super.dispose();
  }

  Future<void> openBox() async {
    tripBox = await Hive.openBox<Tripmodel>('tripdbbox');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: CustomButton(
            width: double.infinity,
            child: CustomText(text: 'Upload photos'),
            onPressed: () {
              uploadmultiphotos(tripmodelobj.key);
            },
          ),
        ),
        tripmodelobj.tripDetail?.tripphotos == null ||
                tripmodelobj.tripDetail!.tripphotos!.isEmpty
            ? SizedBox()
            : Expanded(
                child: GridView.builder(
                  itemCount: tripmodelobj.tripDetail!.tripphotos!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final image = tripmodelobj.tripDetail!.tripphotos![index];
                  //  print('Loading image: $image'); // Debug print
                    return Card(
                      color: Colors.amber,
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Image.file(File(image), fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  uploadmultiphotos(var key) async {
    var pickedfiles = await imagemultipicker.pickMultiImage();
    if (pickedfiles != null && pickedfiles.isNotEmpty) {
      List<String> images = pickedfiles.map((e) => e.path).toList();

      setState(() {
        if (tripmodelobj.tripDetail?.tripphotos == null) {
          tripmodelobj.tripDetail?.tripphotos = images;
        } else {
          tripmodelobj.tripDetail?.tripphotos!.addAll(images);
        }
      });

      // Clone the trip detail to avoid the Hive error
      // tripmodelobj.tripDetail = tripmodelobj.tripDetail?.clone();

      try {
        await tripmodelobj.save();
      } catch (e) {
        print("Error saving tripmodel: $e");
      }
    }
  }
}
