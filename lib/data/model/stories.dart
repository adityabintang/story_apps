// To parse this JSON data, do
//
//     final storiesResults = storiesResultsFromJson(jsonString);


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storys_apps/data/model/list_story.dart';
part 'stories.freezed.dart';
part 'stories.g.dart';

@Freezed()
class StoriesResults with _$StoriesResults{
  const factory StoriesResults({
    bool? error,
    String? message,
    @JsonKey(name: "listStory") required List<ListStory>? listStory,
  }) = _StoriesResults;

  factory StoriesResults.fromJson(Map<String, dynamic> json) => _$StoriesResultsFromJson(json);
}



