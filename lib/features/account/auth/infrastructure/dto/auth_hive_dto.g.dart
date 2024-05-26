// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_hive_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthHiveDtoAdapter extends TypeAdapter<AuthHiveDto> {
  @override
  final int typeId = 0;

  @override
  AuthHiveDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthHiveDto(
      accessToken: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthHiveDto obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthHiveDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
