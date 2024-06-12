// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atripdetail_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripDetailAdapter extends TypeAdapter<TripDetail> {
  @override
  final int typeId = 2;

  @override
  TripDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripDetail(
      checklist: (fields[1] as List?)?.cast<String>(),
      nearplace: (fields[2] as List?)?.cast<String>(),
      notes: (fields[0] as List?)?.cast<String>(),
      spendexpence: (fields[3] as List?)?.cast<int>(),
      tripphotos: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TripDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.notes)
      ..writeByte(1)
      ..write(obj.checklist)
      ..writeByte(2)
      ..write(obj.nearplace)
      ..writeByte(3)
      ..write(obj.spendexpence)
      ..writeByte(4)
      ..write(obj.tripphotos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
