// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartProvider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      quantity: fields[1] as int,
      price: fields[2] as Decimal,
      name: fields[6] as String,
      price2: fields[5] as Decimal,
      product_id: fields[3] as int,
      image: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.price.toString())
      ..writeByte(3)
      ..write(obj.product_id)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.price2.toString())
      ..writeByte(6)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
