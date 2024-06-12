import 'package:hive_flutter/adapters.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
part 'trip_model.g.dart';

@HiveType(typeId: 1)
class Tripmodel extends HiveObject {
  @HiveField(0)
  String destination;
  @HiveField(1)
  DateTime startdate;
  @HiveField(2)
  DateTime enddate;
  @HiveField(3)
  int budget;
  @HiveField(4)
  String? image;
  @HiveField(5)
  TripDetail? tripDetail;

  Tripmodel(
      {required this.destination,
      required this.startdate,
      required this.enddate,
      required this.budget,
      this.tripDetail,
      this.image});
}
