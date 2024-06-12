import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travelapp/db/db_model/trip_model.dart';

ValueNotifier<List<Tripmodel>> tripnotifier = ValueNotifier([]);

class Tripdb extends ChangeNotifier {
  //*Create function
  Future<void> addData(Tripmodel trip) async {
    final box = await Hive.openBox<Tripmodel>('tripdbbox');
    await box.add(trip);
    await box.close();
    await getAll();
  }

  //*Read alltrips function
  Future getAll() async {
    final box = await Hive.openBox<Tripmodel>('tripdbbox');
    tripnotifier.value.clear();
    tripnotifier.value.addAll(box.values.toList());
    tripnotifier.notifyListeners();
    box.close();
  }

  //*Detailing trip page places adding function
  Future addnearbyplaces(Tripmodel trip, int key) async {
    Tripmodel tripmodel = Tripmodel(
        destination: trip.destination,
        startdate: trip.startdate,
        enddate: trip.enddate,
        budget: trip.budget);
    final box = await Hive.openBox<Tripmodel>('tripdbbox');
    await box.putAt(key, tripmodel);
    //  print(tripmodel.tripDetail?.nearplace);
    box.close();
  }

  Future<void> deletetrip(int key) async {
    final box = await Hive.openBox<Tripmodel>('tripdbbox');
    await box.delete(key);
    await getAll();
  }
}
