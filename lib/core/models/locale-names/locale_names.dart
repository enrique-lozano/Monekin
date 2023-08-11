import 'package:json_annotation/json_annotation.dart';

part 'locale_names.g.dart';

@JsonSerializable()
class LocaleNames {
  String en;
  String? es;

  LocaleNames({required this.en, this.es});

  factory LocaleNames.fromJson(Map<String, String> json) =>
      _$LocaleNamesFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleNamesToJson(this);
}
