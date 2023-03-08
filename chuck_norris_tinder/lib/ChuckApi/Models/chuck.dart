import 'package:json_annotation/json_annotation.dart';

part 'chuck.g.dart';

@JsonSerializable()
class Chuck {
  @JsonKey(name: 'url')
  final String jokeUrl;

  @JsonKey(name: 'id')
  final String jokeId;

  @JsonKey(name: 'value')
  final String jokeValue;

  Chuck(this.jokeUrl, this.jokeId, this.jokeValue);

  factory Chuck.fromJson(Map<String, dynamic> json) => _$ChuckFromJson(json);
  Map<String, dynamic> toJson() => _$ChuckToJson(this);
}