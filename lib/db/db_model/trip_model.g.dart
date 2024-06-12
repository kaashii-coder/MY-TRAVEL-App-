// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripmodelAdapter extends TypeAdapter<Tripmodel> {
  @override
  final int typeId = 1;

  @override
  Tripmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tripmodel(
      destination: fields[0] as String,
      startdate: fields[1] as DateTime,
      enddate: fields[2] as DateTime,
      budget: fields[3] as int,
      tripDetail: fields[5] as TripDetail?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Tripmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.destination)
      ..writeByte(1)
      ..write(obj.startdate)
      ..writeByte(2)
      ..write(obj.enddate)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.tripDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
