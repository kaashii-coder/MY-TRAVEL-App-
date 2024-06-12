import 'package:hive_flutter/adapters.dart';
part 'atripdetail_modal.g.dart';

@HiveType(typeId: 2)
class TripDetail extends HiveObject {
  @HiveField(0)
  List<String>? notes;
  @HiveField(1)
  List<String>? checklist;
  @HiveField(2)
 List <String>? nearplace;
  @HiveField(3)
  List<int>? spendexpence;
  @HiveField(4)
  List<String>? tripphotos;
  TripDetail({
    this.checklist,
    this.nearplace,
    this.notes,
    this.spendexpence,
    this.tripphotos,
  });
  
  // Clone method to avoid Hive object issues
  // TripDetail clone() {
  //   return TripDetail(
  //     notes: List<String>.from(notes ?? []),
  //     checklist: String.trim(checklist ?? []),
  //     nearplace: String.from(nearplace ?? []),
  //     spendexpence: List<int>.from(spendexpence ?? []),
  //     tripphotos: List<String>.from(tripphotos ?? []),
  //   );
  // }
}
