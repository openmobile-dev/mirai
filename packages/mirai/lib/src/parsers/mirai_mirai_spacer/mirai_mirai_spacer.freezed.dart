// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mirai_mirai_spacer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MiraiMiraiSpacer _$MiraiMiraiSpacerFromJson(Map<String, dynamic> json) {
  return _MiraiMiraiSpacer.fromJson(json);
}

/// @nodoc
mixin _$MiraiMiraiSpacer {
  int get flex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MiraiMiraiSpacerCopyWith<MiraiMiraiSpacer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiraiMiraiSpacerCopyWith<$Res> {
  factory $MiraiMiraiSpacerCopyWith(
          MiraiMiraiSpacer value, $Res Function(MiraiMiraiSpacer) then) =
      _$MiraiMiraiSpacerCopyWithImpl<$Res, MiraiMiraiSpacer>;
  @useResult
  $Res call({int flex});
}

/// @nodoc
class _$MiraiMiraiSpacerCopyWithImpl<$Res, $Val extends MiraiMiraiSpacer>
    implements $MiraiMiraiSpacerCopyWith<$Res> {
  _$MiraiMiraiSpacerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flex = null,
  }) {
    return _then(_value.copyWith(
      flex: null == flex
          ? _value.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MiraiMiraiSpacerImplCopyWith<$Res>
    implements $MiraiMiraiSpacerCopyWith<$Res> {
  factory _$$MiraiMiraiSpacerImplCopyWith(_$MiraiMiraiSpacerImpl value,
          $Res Function(_$MiraiMiraiSpacerImpl) then) =
      __$$MiraiMiraiSpacerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int flex});
}

/// @nodoc
class __$$MiraiMiraiSpacerImplCopyWithImpl<$Res>
    extends _$MiraiMiraiSpacerCopyWithImpl<$Res, _$MiraiMiraiSpacerImpl>
    implements _$$MiraiMiraiSpacerImplCopyWith<$Res> {
  __$$MiraiMiraiSpacerImplCopyWithImpl(_$MiraiMiraiSpacerImpl _value,
      $Res Function(_$MiraiMiraiSpacerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flex = null,
  }) {
    return _then(_$MiraiMiraiSpacerImpl(
      flex: null == flex
          ? _value.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MiraiMiraiSpacerImpl implements _MiraiMiraiSpacer {
  const _$MiraiMiraiSpacerImpl({this.flex = 1});

  factory _$MiraiMiraiSpacerImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiraiMiraiSpacerImplFromJson(json);

  @override
  @JsonKey()
  final int flex;

  @override
  String toString() {
    return 'MiraiMiraiSpacer(flex: $flex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiraiMiraiSpacerImpl &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, flex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MiraiMiraiSpacerImplCopyWith<_$MiraiMiraiSpacerImpl> get copyWith =>
      __$$MiraiMiraiSpacerImplCopyWithImpl<_$MiraiMiraiSpacerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MiraiMiraiSpacerImplToJson(
      this,
    );
  }
}

abstract class _MiraiMiraiSpacer implements MiraiMiraiSpacer {
  const factory _MiraiMiraiSpacer({final int flex}) = _$MiraiMiraiSpacerImpl;

  factory _MiraiMiraiSpacer.fromJson(Map<String, dynamic> json) =
      _$MiraiMiraiSpacerImpl.fromJson;

  @override
  int get flex;
  @override
  @JsonKey(ignore: true)
  _$$MiraiMiraiSpacerImplCopyWith<_$MiraiMiraiSpacerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
