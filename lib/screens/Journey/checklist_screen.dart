import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class JourneyChecklistPage extends StatefulWidget {
  final Tripmodel checklistData;
  const JourneyChecklistPage({super.key, required this.checklistData});

  @override
  State<JourneyChecklistPage> createState() => _JourneyChecklistPageState();
}

class _JourneyChecklistPageState extends State<JourneyChecklistPage> {
  final TextEditingController checklistController = TextEditingController();
  late Tripmodel checklistFinalDAta;
  bool ischecked = false;
  late int checklistKey;
  List<Color> colorSelector = [
    const Color.fromARGB(255, 216, 222, 227),
    const Color.fromARGB(255, 145, 177, 204),
    const Color.fromARGB(255, 106, 138, 163),
    const Color.fromARGB(255, 81, 131, 170)
  ];
  @override
  void initState() {
  
    super.initState();
    checklistFinalDAta = widget.checklistData;
    checklistKey = checklistFinalDAta.key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: checklistController,
              validator: (value) {
                  if(value!.length>25){
                                    return 'Item name cannot exceed 25 characters.';
                                  }
                  return null;
              },
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
                          icon: const Icon(Icons.check)))),
            ),const SizedBox(height: 20,),
            checklistFinalDAta.checklistModal == null||checklistFinalDAta.checklistModal!.isEmpty
                ?  const Expanded(
                  // width: double.infinity,

                          child: Column(
                          children: [
                         //   SizedBox(width: double.infinity,child: Image.asset('Asset/Image/Add notes-amico.png',height: 280,)),
                            Text('No items added yet'),
                          ],
                                                ),
                        )
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
                                    checklistItem.isChecked = value!;
                                  });
                                  await Tripdb().editDetails(checklistFinalDAta,
                                      checklistFinalDAta.key);
                                }),
                            title: CustomText(
                                text: checklistFinalDAta
                                    .checklistModal![index].title!),
                            trailing:  IconButton(onPressed: (){
                              showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: const CustomText(
                                                                    text:
                                                                        'Confirm to delete'),
                                                                content: const CustomText(
                                                                    text:
                                                                        'Are you sure ,you wanted to delete this item'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const CustomText(
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

                                                                        // ignore: use_build_context_synchronously
                                                                        Navigator.pop(
                                                                            context);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child: const CustomText(
                                                                          text:
                                                                              'Yes'))
                                                                ],
                                                              ));
                            }, icon: Icon(Icons.delete_rounded)),
                            
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
