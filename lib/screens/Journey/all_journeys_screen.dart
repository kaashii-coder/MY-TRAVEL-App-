import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/custom_widgests/search_delegate.dart';
import 'package:travelapp/db/db_function/tripdb_function.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
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
  late TabController _tabController;
  List<Tripmodel> ongoingtrips = [];
  List<Tripmodel> completedtrips = [];
  late String querysearch;
  @override
  void initState() {
    super.initState();

    querysearch = widget.query ?? '';
    _tabController =
        TabController(length: 3, vsync: this); // Change the length as needed
    // Tripdb().gettrips();
    // filterTrips();
    fetchAndFilterTrips();
  }

  void fetchAndFilterTrips() async {
    await Tripdb().getAll();
    filterTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'My Journeys'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search_rounded))
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 0, 0, 0),
          labelColor: Colors.black,
          tabs: const [
            Tab(
              text: 'All Trips',
            ),
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
            // Tab(text: 'Incomplete'),
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
                        ? Center(child: Text('no result'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              var tripplace = results[index].destination;
                              var tripSTdate = DateFormat('dd:MM:yyyy')
                                  .format(results[index].startdate);
                              var tripbudget = results[index].budget.toString();
                              final data = results[index];
                              
                              
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
                                            ? SizedBox(
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
                                                          deletingFunc(
                                                              data.key);
                                                        },
                                                        value: 'option1',
                                                        child: Text('Delete'),
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
                                              const LinearProgressIndicator(
                                                backgroundColor: Colors.grey,
                                                value: 0.10,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const CustomText(
                                                text: 'Your spends:',
                                                color: Color.fromARGB(
                                                    255, 116, 114, 114),
                                              ),
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
                          var tripSTdate = DateFormat('dd:MM:yyyy')
                              .format(ongoingtrips[index].startdate);
                          var tripbudget =
                              ongoingtrips[index].budget.toString();
                          final data = ongoingtrips[index];
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
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: Image.file(
                                              File(ongoingtrips[index].image!),
                                              fit: BoxFit.fill,
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
                                      padding: const EdgeInsets.only(
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
                                              PopupMenuButton<String>(
                                                onSelected: (String value) {},
                                                itemBuilder: (BuildContext
                                                        context) =>
                                                    <PopupMenuEntry<String>>[
                                                  const PopupMenuItem<String>(
                                                    value: 'option1',
                                                    child: Text('Delete'),
                                                  ),
                                                  const PopupMenuItem<String>(
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
                                          const LinearProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            value: 0.10,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const CustomText(
                                            text: 'Your spends:',
                                            color: Color.fromARGB(
                                                255, 116, 114, 114),
                                          ),
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
                          var tripSTdate = DateFormat('dd:MM:yyyy')
                              .format(completedtrips[index].startdate);
                          var tripbudget =
                              completedtrips[index].budget.toString();
                          final data = completedtrips[index];
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
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: Image.file(
                                              File(
                                                  completedtrips[index].image!),
                                              fit: BoxFit.fill,
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
                                      padding: const EdgeInsets.only(
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
                                              PopupMenuButton<String>(
                                                onSelected: (String value) {},
                                                itemBuilder: (BuildContext
                                                        context) =>
                                                    <PopupMenuEntry<String>>[
                                                  const PopupMenuItem<String>(
                                                    value: 'option1',
                                                    child: Text('Delete'),
                                                  ),
                                                  const PopupMenuItem<String>(
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
                                          const LinearProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            value: 0.10,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const CustomText(
                                            text: 'Your spends:',
                                            color: Color.fromARGB(
                                                255, 116, 114, 114),
                                          ),
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
    // currentTrip = allTrips
    //     .where(
    //         (trip) => trip.startDate.isBefore(now) && trip.endDate.isAfter(now))
    //     .toList();
    completedtrips =
        allTrips.where((trip) => trip.enddate.isBefore(now)).toList();
    ongoingtrips =
        allTrips.where((trip) => trip.startdate.isAfter(now)).toList();
    setState(() {});
  }

  deletingFunc(dynamic key) {
    Tripdb().deletetrip(key);
    print('deletepagefunc');
  }
}
