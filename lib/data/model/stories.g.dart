// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoriesResults _$$_StoriesResultsFromJson(Map<String, dynamic> json) =>
    _$_StoriesResults(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) => ListStory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_StoriesResultsToJson(_$_StoriesResults instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
