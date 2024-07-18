import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
import 'package:travelapp/screens/Journey/checklist_screen.dart';
import 'package:travelapp/screens/Journey/expence_list.dart';
import 'package:travelapp/screens/Journey/nearby_places.dart';
import 'package:travelapp/screens/Journey/notes.dart';
import 'package:travelapp/screens/Journey/photo_collection.dart';

// ignore: must_be_immutable
class JourneyCustomMain extends StatefulWidget {
  Tripmodel modelobj; 
  JourneyCustomMain({required this.modelobj, super.key});

  @override
  State<JourneyCustomMain> createState() => _JourneyCustomMain();
}

class _JourneyCustomMain extends State<JourneyCustomMain> {
  late int indexSelect;
  late Tripmodel onetrip;
  late final List _pages;
  late int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    onetrip = widget.modelobj;
    // int _selectedIndex = 0;
    _pages = [
       NearbyPlaceaddPage(placeobj: onetrip,),
       JourneyChecklistPage(checklistData: onetrip,),
       JourneynotesPage(data: onetrip,),
      JourneyPhotosPage(
        tripmodelobj: onetrip,
      ),
       ExpenceListPage(expenceobj:onetrip ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 282),
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: 170,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Card(
                      child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    height: 158,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomText(
                              text: 'Trip to ',
                              size: 20,
                            ),
                            CustomText(
                              text: onetrip.destination,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Card(
                              color: const Color.fromARGB(255, 148, 199, 241),
                              child: CustomText(
                                  text: DateFormat(' dd/MM/yyyy ')
                                      .format(onetrip.startdate)),
                            ),
                            const CustomText(text: 'To'),
                            CustomText(
                                text: DateFormat(' dd/MM/yyyy ')
                                    .format(onetrip.enddate)),
                          ],
                        ),

                        const SizedBox(
                          height: 2,
                        ),
                        const Divider(
                          thickness: .5,
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.person_pin,
                              size: 45,
                            ),
                            // CustomButton(
                            //     child: const CustomText(
                            //       text: 'Invite Friend',
                            //     ),
                            //     onPressed: () {})
                          ],
                        )
                      ],
                    ),
                  )),
                ],
              ),
            )
          ])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(221, 0, 0, 0),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timeline_sharp,
              size: 35,
            ),
            label: 'AddPlace',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist_sharp,
              size: 35,
            ),
            label: 'Checklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_alt_outlined,
              size: 35,
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_size_select_actual_outlined,
              size: 35,
            ),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.currency_exchange_outlined,
              size: 35,
            ),
            label: 'Expences',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    //* tab changes want to effect bottomsheet so this if function is for that one
    if (_scaffoldkey.currentState?.hasEndDrawer == true) {
      Navigator.pop(context);
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}
