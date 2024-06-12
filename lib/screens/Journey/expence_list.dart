import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';

class ExpenceListPage extends StatefulWidget {
  ExpenceListPage({super.key});

  @override
  State<ExpenceListPage> createState() => _ExpenceListPageState();
}

class _ExpenceListPageState extends State<ExpenceListPage> {
  final GlobalKey<FormState> expformkey = GlobalKey<FormState>();

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
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "you're all settled",
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        CustomText(
                          text: "(₹)0.00",
                          size: 20,
                          fontweight: FontWeight.w900,
                          color: Color.fromARGB(255, 0, 140, 255),
                        ),
                        CustomText(
                          text: "you spends:₹0.00",
                          size: 13,
                          fontweight: FontWeight.w500,
                          color: Color.fromARGB(255, 161, 162, 163),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              style: const ButtonStyle(),
                              icon: const Icon(Icons.compare_arrows_sharp),
                              color: Colors.black,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.balance),
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const CustomText(
                          text: 'Your planned budget is :',
                          fontweight: FontWeight.w400,
                        ),
                        const SizedBox(
                            width: 300,
                            height: 8,
                            child: LinearProgressIndicator(
                              value: 0.01,
                            )),
                        const CustomText(text: 'Total spend:0'),
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
                                              height: 330,
                                              width: double.infinity,
                                              padding: EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: const Color.fromARGB(
                                                      255, 0, 117, 212)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(right: 20,left: 20,),
                                                child: Form(
                                                  key: expformkey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Record your expence',
                                                        size: 20,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      TextFormField(
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration: InputDecoration(
                                                            suffixIcon: Icon(Icons
                                                                .currency_rupee),
                                                            labelText:
                                                                'Expence/cost',
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255))),
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
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        decoration: InputDecoration(
                                                            suffixIcon: Icon(Icons
                                                                .description_outlined),
                                                            prefixIconColor:
                                                                Colors.white,
                                                            labelText:
                                                                'Description',
                                                            labelStyle: TextStyle(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255))),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'please add your description';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      CustomButton(
                                                          color: Colors.white,
                                                          child: CustomText(
                                                            text: 'Add',
                                                          ),
                                                          onPressed: () {
                                                            modalsheetaddbuttonclick();
                                                          })
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
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: ListTile(
                      title: Text('First Expences'),
                      trailing: Text('00000'),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 170,
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                          width: 40,
                                          child: Divider(color: Colors.black,
                                            thickness: 5,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: CustomText(color: Colors.red,
                                              text: 'DELETE TRANSACTION')),
                                              Divider(color: Colors.black,
                                            thickness: .25,
                                          ),
                                      TextButton(
                                          onPressed: () {},
                                          child: CustomText(color: Colors.black,text: 'CANCEL'))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    )),
                  ))
        ],
      ),
    );
  }

  modalsheetaddbuttonclick() {
    if (expformkey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }
}
