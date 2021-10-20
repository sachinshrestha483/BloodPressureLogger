// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BpAdapter extends TypeAdapter<Bp> {
  @override
  final int typeId = 1;

  @override
  Bp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bp()
      ..systolic = fields[6] as int
      ..diastolic = fields[1] as int
      ..pulse = fields[2] as int
      ..note = fields[3] as String
      ..userId = fields[5] as String
      ..readingDateTime = fields[9] as DateTime
      ..takenOn = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Bp obj) {
    writer
      ..writeByte(7)
      ..writeByte(6)
      ..write(obj.systolic)
      ..writeByte(1)
      ..write(obj.diastolic)
      ..writeByte(2)
      ..write(obj.pulse)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.readingDateTime)
      ..writeByte(8)
      ..write(obj.takenOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
