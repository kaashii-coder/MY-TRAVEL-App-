import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

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
    Color.fromARGB(255, 216, 222, 227),
    const Color.fromARGB(255, 145, 177, 204),
    const Color.fromARGB(255, 106, 138, 163),
    Color.fromARGB(255, 81, 131, 170)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tripexpobj = widget.expenceobj;

    totalExpencrCalculator(tripexpobj);
    percetageFinder();
  }

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
                        CustomText(
                          text: 'Your planned budget is :',
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        CustomText(
                          text: "(₹)${tripexpobj.budget}",
                          size: 20,
                          fontweight: FontWeight.w900,
                          color: Color.fromARGB(255, 0, 140, 255),
                        ),
                        CustomText(
                          text: "you spends:$sum",
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: Color.fromARGB(255, 161, 162, 163),
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
                        // CustomText(text: 'Total spend:sum'),
                        SizedBox(
                          height: 15,
                        ),
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
                                              //!
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              202,
                                                              202,
                                                              202),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      const CustomText(
                                                        text:
                                                            'Record your expence',
                                                        size: 20,
                                                        color: Colors.black, //!
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
                                                                    Color.fromARGB(
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
                                                                        icon: Icon(Icons
                                                                            .restart_alt_rounded)),
                                                                labelText:
                                                                    'Expence/cost',
                                                                labelStyle: TextStyle(
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
                                                                    Color.fromARGB(
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
                                                                        icon: Icon(Icons
                                                                            .restart_alt_rounded)),
                                                                labelText:
                                                                    'Description',
                                                                labelStyle: TextStyle(
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
                                                          child: CustomText(
                                                            text: 'Cancel',
                                                            color: const Color
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
          SizedBox(
            height: 15,
          ),
          tripexpobj.expenceModal == null
              ? const Text('No Expences record yet')
              : ValueListenableBuilder(
                  valueListenable: expencenotifier,
                  builder: (BuildContext context, list, _) {
                    print(list.length);
                    print(tripexpobj.expenceModal?.length);

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
                                      tripexpobj.expenceModal![index].cost!),
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
                                      const PopupMenuItem<String>(
                                        value: 'option2',
                                        child: Text('Edit'),
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
