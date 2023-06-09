// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stories.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoriesResults _$StoriesResultsFromJson(Map<String, dynamic> json) {
  return _StoriesResults.fromJson(json);
}

/// @nodoc
mixin _$StoriesResults {
  bool? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: "listStory")
  List<ListStory>? get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoriesResultsCopyWith<StoriesResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoriesResultsCopyWith<$Res> {
  factory $StoriesResultsCopyWith(
          StoriesResults value, $Res Function(StoriesResults) then) =
      _$StoriesResultsCopyWithImpl<$Res, StoriesResults>;
  @useResult
  $Res call(
      {bool? error,
      String? message,
      @JsonKey(name: "listStory") List<ListStory>? listStory});
}

/// @nodoc
class _$StoriesResultsCopyWithImpl<$Res, $Val extends StoriesResults>
    implements $StoriesResultsCopyWith<$Res> {
  _$StoriesResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? listStory = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      listStory: freezed == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoriesResultsCopyWith<$Res>
    implements $StoriesResultsCopyWith<$Res> {
  factory _$$_StoriesResultsCopyWith(
          _$_StoriesResults value, $Res Function(_$_StoriesResults) then) =
      __$$_StoriesResultsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? error,
      String? message,
      @JsonKey(name: "listStory") List<ListStory>? listStory});
}

/// @nodoc
class __$$_StoriesResultsCopyWithImpl<$Res>
    extends _$StoriesResultsCopyWithImpl<$Res, _$_StoriesResults>
    implements _$$_StoriesResultsCopyWith<$Res> {
  __$$_StoriesResultsCopyWithImpl(
      _$_StoriesResults _value, $Res Function(_$_StoriesResults) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? listStory = freezed,
  }) {
    return _then(_$_StoriesResults(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      listStory: freezed == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoriesResults implements _StoriesResults {
  const _$_StoriesResults(
      {this.error,
      this.message,
      @JsonKey(name: "listStory") required final List<ListStory>? listStory})
      : _listStory = listStory;

  factory _$_StoriesResults.fromJson(Map<String, dynamic> json) =>
      _$$_StoriesResultsFromJson(json);

  @override
  final bool? error;
  @override
  final String? message;
  final List<ListStory>? _listStory;
  @override
  @JsonKey(name: "listStory")
  List<ListStory>? get listStory {
    final value = _listStory;
    if (value == null) return null;
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StoriesResults(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoriesResults &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoriesResultsCopyWith<_$_StoriesResults> get copyWith =>
      __$$_StoriesResultsCopyWithImpl<_$_StoriesResults>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoriesResultsToJson(
      this,
    );
  }
}

abstract class _StoriesResults implements StoriesResults {
  const factory _StoriesResults(
      {final bool? error,
      final String? message,
      @JsonKey(name: "listStory")
          required final List<ListStory>? listStory}) = _$_StoriesResults;

  factory _StoriesResults.fromJson(Map<String, dynamic> json) =
      _$_StoriesResults.fromJson;

  @override
  bool? get error;
  @override
  String? get message;
  @override
  @JsonKey(name: "listStory")
  List<ListStory>? get listStory;
  @override
  @JsonKey(ignore: true)
  _$$_StoriesResultsCopyWith<_$_StoriesResults> get copyWith =>
      throw _privateConstructorUsedError;
}
