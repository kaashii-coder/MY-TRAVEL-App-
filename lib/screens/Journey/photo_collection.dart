import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
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
    tripmodelobj.photosModal ??= [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: CustomButton(
            width: double.infinity,
            child: const CustomText(text: 'Upload photos'),
            onPressed: () {
              uploadmultiphotos(tripmodelobj.key);
            },
          ),
        ),
        tripmodelobj.photosModal == null || tripmodelobj.photosModal!.isEmpty
            ? const SizedBox()
            : Expanded(
                child: ValueListenableBuilder(
                    valueListenable: imageNotifier,
                    builder: (BuildContext context, list, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: tripmodelobj.photosModal?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final image =
                                tripmodelobj.photosModal?[index].image;

                            return kIsWeb
                                ? SizedBox(
                                    height: 100,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          tripmodelobj
                                              .photosModal![index].image!,
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : GestureDetector(onTap: () {
                                  
                                },
                                  child: SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                            File(tripmodelobj
                                                .photosModal![index].image!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                );
                          },
                        ),
                      );
                    }),
              ),
      ],
    );
  }

  uploadmultiphotos(var key) async {
    var pickedfiles = await imagemultipicker.pickMultiImage();
    if (pickedfiles != null && pickedfiles.isNotEmpty) {
      // print('picked legth');
      log(pickedfiles.length);
      List<String> images = [];
      pickedfiles.forEach(
        (element) => images.add(element.path),
      );
      // print('image legth');
      // print(images.length);
      for (var element in images) {
        final Photo = PhotosModal(image: element);
        tripmodelobj.photosModal == null
            ? tripmodelobj.photosModal = [Photo]
            : tripmodelobj.photosModal?.add(Photo);
        await Tripdb().addnearbyplaces(tripmodelobj, key).then((value) {
          imageNotifier.value.add(Photo);
          imageNotifier.notifyListeners();
        });
      }
      setState(() {});


      try {
        await tripmodelobj.save();
      } catch (e) {
        print("Error saving tripmodel: $e");
      }
    }
  }
}
