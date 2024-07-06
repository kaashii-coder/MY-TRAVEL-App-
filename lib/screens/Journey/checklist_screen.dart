import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class JourneyChecklistPage extends StatefulWidget {
  final Tripmodel checklistData;
  JourneyChecklistPage({super.key, required this.checklistData});

  @override
  State<JourneyChecklistPage> createState() => _JourneyChecklistPageState();
}

class _JourneyChecklistPageState extends State<JourneyChecklistPage> {
  final TextEditingController checklistController = TextEditingController();
  late Tripmodel checklistFinalDAta;
  bool ischecked = false;
  late int checklistKey;
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
    checklistFinalDAta = widget.checklistData;
    checklistKey = checklistFinalDAta.key;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            TextFormField(
              controller: checklistController,
              decoration: InputDecoration(
                  labelText: 'Add Checklist',
                  hintText: 'Add items like Tickets, passport',
                  suffix: Card(
                      child: IconButton(
                          onPressed: () {
                            String checklistItem =
                                checklistController.text.trim();
                            if (checklistItem.isNotEmpty) {
                              final checklistCarrier = ChecklistModal(
                                  title: checklistItem, isChecked: false);
                              checklistFinalDAta.checklistModal == null
                                  ? checklistFinalDAta.checklistModal = [
                                      checklistCarrier
                                    ]
                                  : checklistFinalDAta.checklistModal!
                                      .add(checklistCarrier);
                              Tripdb().addnearbyplaces(
                                  checklistFinalDAta, checklistKey);
                              setState(() {
                                checklistController.clear();
                              });
                            }
                          },
                          icon: Icon(Icons.check)))),
            ),SizedBox(height: 20,),
            checklistFinalDAta.checklistModal == null
                ? Column(children: [
                    // Image.asset('Asset/Image/Add notes-amico.png'),
                    SizedBox(height: 30,),
                    Text('No items added yet '),
                  ])
                : Expanded(
                    child: ListView.builder(
                      itemCount: checklistFinalDAta.checklistModal?.length,
                      itemBuilder: (context, index) {
                        final checklistItem =
                            checklistFinalDAta.checklistModal![index];

                        return Card(color:colorSelector[index%colorSelector.length] ,
                          child: ListTile(
                            leading: Checkbox(
                                value: checklistItem.isChecked,
                                onChanged: (value) async {
                                  setState(() {
                                    // ischecked = value!;
                                    // checklistFinalDAta.checklistModal![index]
                                    //     .isChecked = value;

                                    checklistItem.isChecked = value!;
                                  });
                                  await Tripdb().editDetails(checklistFinalDAta,
                                      checklistFinalDAta.key);
                                }),
                            title: CustomText(
                                text: checklistFinalDAta
                                    .checklistModal![index].title!),
                            trailing: Icon(Icons.checklist_rounded),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 170,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                                width: 40,
                                                child: Divider(
                                                  color: Colors.black,
                                                  thickness: 5,
                                                )),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: CustomText(
                                                                    text:
                                                                        'Confirm to delete'),
                                                                content: CustomText(
                                                                    text:
                                                                        'Are you sure ,you wanted to delete this trip'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: CustomText(
                                                                          text:
                                                                              'No')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        checklistFinalDAta
                                                                            .checklistModal!
                                                                            .removeAt(index);
                                                                        await Tripdb().editDetails(
                                                                            checklistFinalDAta,
                                                                            checklistFinalDAta.key);

                                                                        Navigator.pop(
                                                                            context);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child: CustomText(
                                                                          text:
                                                                              'Yes'))
                                                                ],
                                                              ));
                                                },
                                                child: const CustomText(
                                                    color: Colors.red,
                                                    text:
                                                        'DELETE TRANSACTION')),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: .25,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const CustomText(
                                                    color: Colors.black,
                                                    text: 'CANCEL'))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
