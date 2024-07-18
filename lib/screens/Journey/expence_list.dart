import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
import 'package:travelapp/screens/Creater/trip_edit_page.dart';

// ignore: must_be_immutable
class ExpenceListPage extends StatefulWidget {
  Tripmodel expenceobj;

  ExpenceListPage({super.key, required this.expenceobj});

  @override
  State<ExpenceListPage> createState() => _ExpenceListPageState();
}

class _ExpenceListPageState extends State<ExpenceListPage> {
  late int selectedIndex;
  final GlobalKey<FormState> expformkey = GlobalKey<FormState>();
  final TextEditingController costController = TextEditingController();
  final TextEditingController costTitleController = TextEditingController();

  late Tripmodel tripexpobj;
  double percentage = 0;
  int sum = 0;
  List<Color> colorSelector = [
    const Color.fromARGB(255, 216, 222, 227),
    const Color.fromARGB(255, 145, 177, 204),
    const Color.fromARGB(255, 106, 138, 163),
    const Color.fromARGB(255, 81, 131, 170)
  ];
  @override
  void initState() {
    
    super.initState();
    tripexpobj = widget.expenceobj;

    totalExpencrCalculator(tripexpobj);
    percetageFinder();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //height: 216,
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Card(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Your planned budget is :',
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        CustomText(
                          text: "(₹)${tripexpobj.budget}",
                          size: 20,
                          fontweight: FontWeight.w900,
                          color: const Color.fromARGB(255, 0, 140, 255),
                        ),
                        CustomText(
                          text: "you spends:$sum",
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: const Color.fromARGB(255, 161, 162, 163),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        CustomText(
                          text:
                              'Your budget percentage is :${percentage * 100}%',
                          fontweight: FontWeight.w400,
                        ),
                        SizedBox(
                            width: 300,
                            height: 8,
                            child: LinearProgressIndicator(
                              value: percentage,
                            )),
                        sum >= tripexpobj.budget
                            ? SizedBox(
                                child: Row(
                                children: [
                                  const CustomText(
                                    text:
                                        'Your planned budget reached - reset budget',
                                    color: Colors.red,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTripscrren(
                                                        editTrip: tripexpobj)));
                                      },
                                      child: const CustomText(
                                        text: '>>click here<<',
                                        color: Colors.black,
                                      ))
                                ],
                              ))
                            : const SizedBox(),
                        // CustomText(text: 'Total spend:sum'),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                                child: const CustomText(text: 'Add Expences'),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: 360,
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30)),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 20,
                                                  left: 20,
                                                ),
                                                child: Form(
                                                  key: expformkey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    // mainAxisSize:
                                                    //     MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 6.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.5),
                                                          color: const Color.fromARGB(
                                                              255,
                                                              202,
                                                              202,
                                                              202),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const CustomText(
                                                        text:
                                                            'Record your expence',
                                                        size: 20,
                                                        color: Colors.black,
                                                        fontweight:
                                                            FontWeight.bold,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            costController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ),
                                                                ),
                                                                suffixIconColor:
                                                                    const Color.fromARGB(
                                                                        255,
                                                                        121,
                                                                        120,
                                                                        120),
                                                                suffixIcon:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          costController
                                                                              .clear();
                                                                        },
                                                                        icon: const Icon(Icons
                                                                            .restart_alt_rounded)),
                                                                labelText:
                                                                    'Expence/cost',
                                                                labelStyle: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            120,
                                                                            120))),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'please add your amount';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            costTitleController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ),
                                                                ),
                                                                suffixIconColor:
                                                                    const Color.fromARGB(
                                                                        255,
                                                                        121,
                                                                        120,
                                                                        120),
                                                                hintText:
                                                                    ' Type... description',
                                                                suffixIcon:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          costTitleController
                                                                              .clear();
                                                                        },
                                                                        icon: const Icon(Icons
                                                                            .restart_alt_rounded)),
                                                                labelText:
                                                                    'Description',
                                                                labelStyle: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            120,
                                                                            120))),
                                                        validator: (value) {
                                                          //!
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'please add your description';
                                                          } else if (value
                                                                  .trim() ==
                                                              value.replaceAll(
                                                                  RegExp(
                                                                      r'[^\d]'),
                                                                  '')) {
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
                                                          width:
                                                              double.infinity,
                                                          color: Colors.blue,
                                                          child:
                                                              const CustomText(
                                                            color: Colors.white,
                                                            text: 'Save',
                                                          ),
                                                          onPressed: () {
                                                            expenceModalsheetAddButtonclick(
                                                                tripexpobj.key);
                                                          }),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const CustomText(
                                                            text: 'Cancel',
                                                            color: Color
                                                                .fromARGB(255,
                                                                101, 100, 100),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                })
                          ],
                        ),
                        //
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          tripexpobj.expenceModal == null
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset('Asset/Image/Add notes-amico.png'),
                      const Text('No expences added yet'),
                    ],
                  ),
                )
              : ValueListenableBuilder(
                  valueListenable: expencenotifier,
                  builder: (BuildContext context, list, _) {
                    // print(list.length);
                    // print(tripexpobj.expenceModal?.length);

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tripexpobj.expenceModal?.length ?? 0,
                        itemBuilder: (context, index) {
                          Color exactColor =
                              colorSelector[index % colorSelector.length];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                                color: exactColor,
                                child: ListTile(
                                  leading: const Icon(Icons.receipt_outlined),
                                  title: Text(tripexpobj
                                      .expenceModal![index].expenceTitle!),
                                  subtitle: Text(
                                      'Rs.${tripexpobj.expenceModal![index].cost}'),
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (String value) {},
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const CustomText(
                                                        text:
                                                            'Confirm to delete'),
                                                    content: const CustomText(
                                                        text:
                                                            'Are you sure ,you wanted to delete this trip'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {},
                                                          child:
                                                              const CustomText(
                                                                  text: 'No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            tripexpobj
                                                                .expenceModal!
                                                                .removeAt(
                                                                    index);
                                                            await Tripdb()
                                                                .editDetails(
                                                                    tripexpobj,
                                                                    tripexpobj
                                                                        .key);

                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context);
                                                            await totalExpencrCalculator(
                                                                tripexpobj);
                                                            await percetageFinder();
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const CustomText(
                                                                  text: 'Yes'))
                                                    ],
                                                  ));
                                        },
                                        value: 'option1',
                                        child: const Text('Delete'),
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          costController.text = tripexpobj
                                              .expenceModal![index].cost!;
                                          costTitleController.text = tripexpobj
                                              .expenceModal![index]
                                              .expenceTitle!;
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      //!
                                                      height: 360,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30)),
                                                          color: Colors.white),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 20,
                                                          left: 20,
                                                        ),
                                                        child: Form(
                                                          //!
                                                          key: expformkey,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            // mainAxisSize:
                                                            //     MainAxisSize.min,
                                                            children: [
                                                              //!
                                                              Container(
                                                                width: 40,
                                                                height: 6.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.5),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          202,
                                                                          202,
                                                                          202),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const CustomText(
                                                                text:
                                                                    'Record your expence',
                                                                size: 20,
                                                                color: Colors
                                                                    .black, //!
                                                                fontweight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              TextFormField(
                                                                controller:
                                                                    costController,
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        suffixIconColor: const Color.fromARGB(
                                                                            255,
                                                                            121,
                                                                            120,
                                                                            120),
                                                                        suffixIcon: IconButton(
                                                                            onPressed: () {
                                                                              costController.clear();
                                                                            },
                                                                            icon: const Icon(Icons.restart_alt_rounded)),
                                                                        labelText: 'Expence/cost',
                                                                        labelStyle: const TextStyle(color: Color.fromARGB(255, 121, 120, 120))),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'please add your amount';
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                              TextFormField(
                                                                controller:
                                                                    costTitleController,
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                decoration:
                                                                    InputDecoration(
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        suffixIconColor: const Color.fromARGB(
                                                                            255,
                                                                            121,
                                                                            120,
                                                                            120),
                                                                        hintText:
                                                                            ' Type... description',
                                                                        suffixIcon: IconButton(
                                                                            onPressed: () {
                                                                              costTitleController.clear();
                                                                            },
                                                                            icon: const Icon(Icons.restart_alt_rounded)),
                                                                        labelText: 'Description',
                                                                        labelStyle: const TextStyle(color: Color.fromARGB(255, 121, 120, 120))),
                                                                validator:
                                                                    (value) {
                                                                  //!
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'please add your description';
                                                                  } else if (value
                                                                          .trim() ==
                                                                      value.replaceAll(
                                                                          RegExp(
                                                                              r'[^\d]'),
                                                                          '')) {
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
                                                                  width: double
                                                                      .infinity,
                                                                  color: Colors
                                                                      .blue,
                                                                  child:
                                                                      const CustomText(
                                                                    color: Colors
                                                                        .white,
                                                                    text:
                                                                        'Save',
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    expenceUpdate(
                                                                        tripexpobj
                                                                            .key,
                                                                        index);
                                                                  }),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const CustomText(
                                                                    text:
                                                                        'Cancel',
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        101,
                                                                        100,
                                                                        100),
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
                                        value: 'option2',
                                        child: const Text('Edit'),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        });
                  })
        ],
      ),
    );
  }

  expenceModalsheetAddButtonclick(dynamic key) async {
    String costTitle = costTitleController.text.trim();
    String costAmount = costController.text.trim();
    if (expformkey.currentState!.validate()) {
      if (costTitle.isNotEmpty && costAmount.isNotEmpty) {
        final expCarrier =
            ExpenceModal(expenceTitle: costTitle, cost: costAmount);
        tripexpobj.expenceModal == null
            ? tripexpobj.expenceModal = [expCarrier]
            : tripexpobj.expenceModal!.add(expCarrier);
        Tripdb().addnearbyplaces(tripexpobj, key);
        await totalExpencrCalculator(tripexpobj);
        await percetageFinder();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        setState(() {
          costController.clear();
          costTitleController.clear();
        });
      }
    }
  }

  expenceUpdate(dynamic key, int index) async {
    String costTitle = costTitleController.text.trim();
    String costAmount = costController.text.trim();
    if (expformkey.currentState!.validate()) {
      if (costTitle.isNotEmpty && costAmount.isNotEmpty) {
        tripexpobj.expenceModal![index].expenceTitle = costTitle;
        tripexpobj.expenceModal![index].cost = costAmount;

        await Tripdb().editDetails(tripexpobj, key);
        await totalExpencrCalculator(tripexpobj);
        await percetageFinder();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        setState(() {
          costController.clear();
          costTitleController.clear();
        });
      }
    }
  }

  totalExpencrCalculator(Tripmodel trip) {
    int tempSum = 0;
    for (var element in trip.expenceModal ?? []) {
      tempSum += int.parse(element.cost!);
    }
    setState(() {
      sum = tempSum;
    });
  }

  percetageFinder() {
    double percentageTemp = sum / tripexpobj.budget;
    setState(() {
      percentage = percentageTemp;
    });
  }
}
