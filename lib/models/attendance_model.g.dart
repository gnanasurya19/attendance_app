// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceModelAdapter extends TypeAdapter<AttendanceModel> {
  @override
  final int typeId = 0;

  @override
  AttendanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceModel(
      date: fields[0] as String?,
      clockInTime: fields[1] as String?,
      clockOutTime: fields[2] as String?,
      workingHrsIn: fields[3] as String?,
      attendanceType: fields[4] as int?,
      isClockInlate: fields[5] as bool?,
      isClockOutlate: fields[6] as bool?,
      isworkHrsLess: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.clockInTime)
      ..writeByte(2)
      ..write(obj.clockOutTime)
      ..writeByte(3)
      ..write(obj.workingHrsIn)
      ..writeByte(4)
      ..write(obj.attendanceType)
      ..writeByte(5)
      ..write(obj.isClockInlate)
      ..writeByte(6)
      ..write(obj.isClockOutlate)
      ..writeByte(7)
      ..write(obj.isworkHrsLess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
