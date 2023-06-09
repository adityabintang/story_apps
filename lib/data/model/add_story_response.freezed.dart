// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddStoryResponse _$AddStoryResponseFromJson(Map<String, dynamic> json) {
  return _AddStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$AddStoryResponse {
  bool? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddStoryResponseCopyWith<AddStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStoryResponseCopyWith<$Res> {
  factory $AddStoryResponseCopyWith(
          AddStoryResponse value, $Res Function(AddStoryResponse) then) =
      _$AddStoryResponseCopyWithImpl<$Res, AddStoryResponse>;
  @useResult
  $Res call({bool? error, String? message});
}

/// @nodoc
class _$AddStoryResponseCopyWithImpl<$Res, $Val extends AddStoryResponse>
    implements $AddStoryResponseCopyWith<$Res> {
  _$AddStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddStoryResponseCopyWith<$Res>
    implements $AddStoryResponseCopyWith<$Res> {
  factory _$$_AddStoryResponseCopyWith(
          _$_AddStoryResponse value, $Res Function(_$_AddStoryResponse) then) =
      __$$_AddStoryResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? error, String? message});
}

/// @nodoc
class __$$_AddStoryResponseCopyWithImpl<$Res>
    extends _$AddStoryResponseCopyWithImpl<$Res, _$_AddStoryResponse>
    implements _$$_AddStoryResponseCopyWith<$Res> {
  __$$_AddStoryResponseCopyWithImpl(
      _$_AddStoryResponse _value, $Res Function(_$_AddStoryResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_AddStoryResponse(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddStoryResponse implements _AddStoryResponse {
  const _$_AddStoryResponse({required this.error, required this.message});

  factory _$_AddStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$$_AddStoryResponseFromJson(json);

  @override
  final bool? error;
  @override
  final String? message;

  @override
  String toString() {
    return 'AddStoryResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddStoryResponse &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddStoryResponseCopyWith<_$_AddStoryResponse> get copyWith =>
      __$$_AddStoryResponseCopyWithImpl<_$_AddStoryResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddStoryResponseToJson(
      this,
    );
  }
}

abstract class _AddStoryResponse implements AddStoryResponse {
  const factory _AddStoryResponse(
      {required final bool? error,
      required final String? message}) = _$_AddStoryResponse;

  factory _AddStoryResponse.fromJson(Map<String, dynamic> json) =
      _$_AddStoryResponse.fromJson;

  @override
  bool? get error;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_AddStoryResponseCopyWith<_$_AddStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
