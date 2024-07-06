import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

class CustomCard extends StatelessWidget {
  final Tripmodel data;
  final int colorIndex;
  CustomCard({super.key, required this.colorIndex, required this.data});
  List<Color> colorSelector = [
    Color.fromARGB(255, 216, 222, 227),
    const Color.fromARGB(255, 145, 177, 204),
    const Color.fromARGB(255, 106, 138, 163),
    Color.fromARGB(255, 81, 131, 170)
  ];

  @override
  Widget build(BuildContext context) {
    Color exactColor = colorSelector[colorIndex % colorSelector.length];
    return Card(
      color: exactColor,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.my_library_books_outlined),
            title: CustomText(text: data.notesModal![colorIndex].title),
            subtitle:
                CustomText(text: data.notesModal![colorIndex].description),
            trailing: PopupMenuButton<String>(
                                                    onSelected:
                                                        (String value) {},
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        <PopupMenuEntry<
                                                            String>>[
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: const CustomText(
                                                                            text:
                                                                                'Confirm to delete'),
                                                                        content:
                                                                            const CustomText(text: 'Are you sure ,you wanted to delete this trip'),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {},
                                                                              child: const CustomText(text: 'No')),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                               // deletingFunc(data.key);
                                                                              },
                                                                              child: const CustomText(text: 'Yes'))
                                                                        ],
                                                                      ));
                                                          
                                                        },
                                                        value: 'option1',
                                                        child: const Text('Delete'),
                                                      ),
                                                      const PopupMenuItem<
                                                          String>(
                                                        value: 'option2',
                                                        child: Text('Edit'),
                                                      ),
                                                    ],
                                                  ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 170,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
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
                                      builder: (context) => AlertDialog(
                                            title: CustomText(
                                                text: 'Confirm to delete'),
                                            content: CustomText(
                                                text:
                                                    'Are you sure ,you wanted to delete this trip'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      CustomText(text: 'No')),
                                              TextButton(
                                                  onPressed: () async {
                                                    
                                                    data.notesModal
                                                        !.removeAt(colorIndex);
                                                    await Tripdb().editDetails(
                                                        data,
                                                        data.key);

                                                    Navigator.pop(context);
                                                    // setState(() {});
                                                  },
                                                  child:
                                                      CustomText(text: 'Yes'))
                                            ],
                                          ));
                                },
                                child: const CustomText(
                                    color: Colors.red,
                                    text: 'DELETE TRANSACTION')),
                            const Divider(
                              color: Colors.black,
                              thickness: .25,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const CustomText(
                                    color: Colors.black, text: 'CANCEL'))
                          ],
                        ),
                      ),
                    );
                  });
            },
          )),
    );
  }
}
