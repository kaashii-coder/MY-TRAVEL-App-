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
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:travelapp/screens/Journey/single_picview.dart';

class JourneyPhotosPage extends StatefulWidget {
  final Tripmodel tripmodelobj;
  const JourneyPhotosPage({required this.tripmodelobj, Key? key})
      : super(key: key);

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
            ? Column(
                          children: [SizedBox(height: 25,),
                         //   SizedBox(width: double.infinity,child: Image.asset('Asset/Image/Add notes-amico.png',height: 280,)),
                            Text('No photos added yet'),
                          ],
                                                )
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
                            // ignore: unused_local_variable
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
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePicViewScreen(
                                                    picviewobj: tripmodelobj,
                                                    selectedIndex: index,
                                                  ))).then((value) {
                                        setState(() {});
                                      });
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
    // ignore: unnecessary_null_comparison
    if (pickedfiles != null && pickedfiles.isNotEmpty) {
      log(pickedfiles.length);
      List<String> images = [];
      // ignore: avoid_function_literals_in_foreach_calls
      pickedfiles.forEach(
        (element) => images.add(element.path),
      );

      for (var element in images) {
        // ignore: non_constant_identifier_names
        final Photo = PhotosModal(image: element);
        tripmodelobj.photosModal == null
            ? tripmodelobj.photosModal = [Photo]
            : tripmodelobj.photosModal?.add(Photo);
        await Tripdb().addnearbyplaces(tripmodelobj, key).then((value) {
          imageNotifier.value.add(Photo);
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          imageNotifier.notifyListeners();
        });
      }
      setState(() {});

      try {
        await tripmodelobj.save();
      } catch (e) {
        // ignore: avoid_print
        print("Error saving tripmodel: $e");
      }
    }
  }
}
