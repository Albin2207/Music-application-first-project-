// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicAdapter extends TypeAdapter<Music> {
  @override
  final int typeId = 0;

  @override
  Music read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Music(
      id: fields[0] == null ? 0 : fields[0] as int,
      path: fields[3] as String,
      title: fields[1] as String,
      artist: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Music obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
