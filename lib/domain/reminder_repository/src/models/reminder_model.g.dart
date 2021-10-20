// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 2;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder()
      ..name = fields[0] as String
      ..time = fields[1] as DateTime
      ..gender = fields[2] as bool
      ..monday = fields[3] as bool
      ..tuesday = fields[4] as bool
      ..wednesday = fields[5] as bool
      ..thursday = fields[6] as bool
      ..friday = fields[7] as bool
      ..saturday = fields[8] as bool
      ..sunday = fields[9] as bool
      ..userId = fields[10] as int
      ..note = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.monday)
      ..writeByte(4)
      ..write(obj.tuesday)
      ..writeByte(5)
      ..write(obj.wednesday)
      ..writeByte(6)
      ..write(obj.thursday)
      ..writeByte(7)
      ..write(obj.friday)
      ..writeByte(8)
      ..write(obj.saturday)
      ..writeByte(9)
      ..write(obj.sunday)
      ..writeByte(10)
      ..write(obj.userId)
      ..writeByte(11)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}