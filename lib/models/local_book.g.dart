// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalBookAdapter extends TypeAdapter<LocalBook> {
  @override
  final int typeId = 0;

  @override
  LocalBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalBook()
      ..title = fields[0] as String?
      ..author = fields[1] as String?
      ..bookImage = fields[2] as String?
      ..publisher = fields[3] as String?
      ..description = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, LocalBook obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.bookImage)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
