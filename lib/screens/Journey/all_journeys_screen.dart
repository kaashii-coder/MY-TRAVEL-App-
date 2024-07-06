import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/custom_widgests/search_delegate.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
import 'package:travelapp/screens/Creater/trips_add_screen.dart';
import 'package:travelapp/screens/Journey/journey_custom_main.dart';

class MyJourneyScreen extends StatefulWidget {
  final String? query;
  MyJourneyScreen({
    super.key,
    this.query,
  });

  @override
  State<MyJourneyScreen> createState() => _MyJourneyScreenState();
}

class _MyJourneyScreenState extends State<MyJourneyScreen>
    with SingleTickerProviderStateMixin {
  var indexCarrier;
  late TabController _tabController;
  List<Tripmodel> ongoingtrips = [];
  List<Tripmodel> completedtrips = [];
  late String querysearch;
  @override
  void initState() {
    super.initState();

    querysearch = widget.query ?? '';
    _tabController =
        TabController(length: 3, vsync: this); 
   
    fetchAndFilterTrips();
  }

  void fetchAndFilterTrips() async {
    await Tripdb().getAll();
    filterTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){ Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTripscrren()));},child:Icon(Icons.add) ,),
      appBar: AppBar(
        title: const CustomText(text: 'My Journeys',color: Colors.white,),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search_rounded,color: Colors.white,))
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 0, 0, 0),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(
              text: 'All Trips',
            ),
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
            
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //! First Tab: All Trips

                ValueListenableBuilder(
                  valueListenable: tripnotifier,
                  builder: (context, list, _) {
                    var results = querysearch.isEmpty
                        ? list
                        : list
                            .where((c) => c.destination
                                .toLowerCase()
                                .contains(querysearch))
                            .toList();
                    return results.isEmpty
                        ? const Center(child: Text('no result'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              var tripplace = results[index].destination;
                              var tripSTdate = DateFormat('dd/MM/yyyy')
                                  .format(results[index].startdate);
                              var tripbudget = results[index].budget.toString();
                              final data = results[index];
                              indexCarrier = index;
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JourneyCustomMain(
                                                  modelobj: data,
                                                )));
                                  },
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        list[index].image != null &&
                                                results[index].image!.isNotEmpty
                                            ?kIsWeb?
                                            SizedBox(
                                                width: double.infinity,
                                                height: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image.network(
                                                    list[index].image!,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )): 
                                            SizedBox(
                                                width: double.infinity,
                                                height: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image.file(
                                                    File(list[index].image!),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ))
                                            : Card(
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: Image.asset(
                                                        'Asset/Image/WhatsApp Image 2024-04-29 at 12.24.29_1a26d094.jpg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )),
                                              ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: 'Trip to $tripplace',
                                                    size: 18,
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w500,
                                                  ),
                                                  PopupMenuButton<String>(
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
                                                                                deletingFunc(data.key);
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
                                                ], // End of Row children
                                              ),
                                              CustomText(
                                                text: 'Start on $tripSTdate',
                                                fontweight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 185, 184, 184),
                                              ),
                                              Text(
                                                  "Your planned budget is: $tripbudget"),
                                              
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),

                //! Second Tab: Upcoming

                ValueListenableBuilder(
                    valueListenable: tripnotifier,
                    builder: (context, list, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ongoingtrips.length,
                        itemBuilder: (context, index) {
                          var tripplace = ongoingtrips[index].destination;
                          var tripSTdate = DateFormat('dd/MM/yyyy')
                              .format(ongoingtrips[index].startdate);
                          var tripbudget =
                              ongoingtrips[index].budget.toString();
                          final data = ongoingtrips[index];
                          indexCarrier = index;
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JourneyCustomMain(
                                              modelobj: data,
                                            )));
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    ongoingtrips[index].image != null &&
                                            ongoingtrips[index]
                                                .image!
                                                .isNotEmpty
                                        ?kIsWeb?
                                        SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: Image.network(
                                              ongoingtrips[index].image!,
                                              fit: BoxFit.fill,
                                            )): 
                                        SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.file(
                                                File(ongoingtrips[index].image!),
                                                fit: BoxFit.fill,
                                              ),
                                            ))
                                        : Card(
                                            child: SizedBox(
                                                width: double.infinity,
                                                height: 150,
                                                child: Image.asset(
                                                  'Asset/Image/WhatsApp Image 2024-04-29 at 12.24.29_1a26d094.jpg',
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10,
                                          bottom: 10, left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: 'Trip to $tripplace',
                                                size: 18,
                                                color: Colors.black,
                                                fontweight: FontWeight.w500,
                                              ),
                                              
                                            ], // End of Row children
                                          ), SizedBox(height: 10,),
                                          CustomText(
                                            text: 'Start on $tripSTdate',
                                            fontweight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 185, 184, 184),
                                          ),
                                          Text(
                                              "Your planned budget is: $tripbudget"),
                                         
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),

                //! Third Tab: Completed

                ValueListenableBuilder(
                    valueListenable: tripnotifier,
                    builder: (context, list, _) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: completedtrips.length,
                        itemBuilder: (context, index) {
                          var tripplace = completedtrips[index].destination;
                          var tripSTdate = DateFormat('dd/MM/yyyy')
                              .format(completedtrips[index].startdate);
                          var tripbudget =
                              completedtrips[index].budget.toString();
                          final data = completedtrips[index];
                          indexCarrier = index;
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JourneyCustomMain(
                                              modelobj: data,
                                            )));
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    completedtrips[index].image != null &&
                                            completedtrips[index]
                                                .image!
                                                .isNotEmpty
                                        ?kIsWeb?
                                        SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: Image.network(
                                              
                                                  completedtrips[index].image!,
                                              fit: BoxFit.fill,
                                            )): 
                                        SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: ClipRRect(borderRadius: BorderRadius.circular(4),
                                              child: Image.file(
                                                File(
                                                    completedtrips[index].image!),
                                                fit: BoxFit.fill,
                                              ),
                                            ))
                                        : Card(
                                            child: SizedBox(
                                                width: double.infinity,
                                                height: 150,
                                                child: Image.asset(
                                                  'Asset/Image/WhatsApp Image 2024-04-29 at 12.24.29_1a26d094.jpg',
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10,
                                          bottom: 10, left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: 'Trip to $tripplace',
                                                size: 18,
                                                color: Colors.black,
                                                fontweight: FontWeight.w500,
                                              ),
                                              
                                            ], // End of Row children
                                          ),
                                          SizedBox(height: 10,),
                                          CustomText(
                                            text: 'Start on $tripSTdate',
                                            fontweight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 185, 184, 184),
                                          ),
                                          Text(
                                              "Your planned budget is: $tripbudget"),
                                          
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
  //* Screen building with this function and return a list

  filterTrips() {
    final now = DateTime.now();
    final allTrips = tripnotifier.value;
    
    completedtrips =
        allTrips.where((trip) => trip.enddate.isBefore(now)).toList();
    ongoingtrips =
        allTrips.where((trip) => trip.startdate.isAfter(now)).toList();
    setState(() {});
  }

  deletingFunc(dynamic key) async {
    await Tripdb().deletetrip(key);
    Navigator.pop(context);
  }
   
}
