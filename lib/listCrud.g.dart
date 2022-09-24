// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listCrud.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListCrudAdapter extends TypeAdapter<ListCrud> {
  @override
  final int typeId = 2;

  @override
  ListCrud read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListCrud(
      list: (fields[0] as List).cast<Animal>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListCrud obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListCrudAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
