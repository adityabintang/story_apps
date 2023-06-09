import 'package:freezed_annotation/freezed_annotation.dart';
part 'list_story.g.dart';
part 'list_story.freezed.dart';


@Freezed()
class ListStory with _$ListStory{
  const factory ListStory({
    required String? id,
    required String? name,
    required String? description,
    required String? photoUrl,
    required DateTime? createdAt,
    required double? lat,
    required double? lon,
  }) = _ListStory;

  // String? id;
  // String? name;
  // String? description;
  // String? photoUrl;
  // DateTime? createdAt;
  // double? lat;
  // double? lon;

  factory ListStory.fromJson(Map<String, dynamic> json) => _$ListStoryFromJson(json);

  // Map<String, dynamic> toJson() => _$ListStoryToJson(this);
}