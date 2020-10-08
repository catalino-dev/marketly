// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_items_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryItemsAdapter extends TypeAdapter<GroceryItems> {
  @override
  final int typeId = 0;

  @override
  GroceryItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryItems(
      category: fields[0] as String,
      items: (fields[1] as List)?.cast<Item>(),
    );
  }

  @override
  void write(BinaryWriter writer, GroceryItems obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
