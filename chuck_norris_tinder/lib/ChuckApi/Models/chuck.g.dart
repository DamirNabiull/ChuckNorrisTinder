// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chuck _$ChuckFromJson(Map<String, dynamic> json) => Chuck(
      json['url'] as String,
      json['id'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$ChuckToJson(Chuck instance) => <String, dynamic>{
      'url': instance.jokeUrl,
      'id': instance.jokeId,
      'value': instance.jokeValue,
    };
