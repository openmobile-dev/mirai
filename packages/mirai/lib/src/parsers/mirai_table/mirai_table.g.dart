// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirai_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MiraiTableImpl _$$MiraiTableImplFromJson(Map<String, dynamic> json) =>
    _$MiraiTableImpl(
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => MiraiTableRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      columnWidths: (json['columnWidths'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k),
            MiraiTableColumnWidth.fromJson(e as Map<String, dynamic>)),
      ),
      defaultColumnWidth: json['defaultColumnWidth'] == null
          ? null
          : MiraiTableColumnWidth.fromJson(
              json['defaultColumnWidth'] as Map<String, dynamic>),
      textDirection:
          $enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
      border: json['border'] == null
          ? null
          : MiraiTableBorder.fromJson(json['border'] as Map<String, dynamic>),
      defaultVerticalAlignment: $enumDecodeNullable(
              _$TableCellVerticalAlignmentEnumMap,
              json['defaultVerticalAlignment']) ??
          TableCellVerticalAlignment.top,
      textBaseline:
          $enumDecodeNullable(_$TextBaselineEnumMap, json['textBaseline']),
    );

Map<String, dynamic> _$$MiraiTableImplToJson(_$MiraiTableImpl instance) =>
    <String, dynamic>{
      'children': instance.children,
      'columnWidths':
          instance.columnWidths?.map((k, e) => MapEntry(k.toString(), e)),
      'defaultColumnWidth': instance.defaultColumnWidth,
      'textDirection': _$TextDirectionEnumMap[instance.textDirection],
      'border': instance.border,
      'defaultVerticalAlignment': _$TableCellVerticalAlignmentEnumMap[
          instance.defaultVerticalAlignment]!,
      'textBaseline': _$TextBaselineEnumMap[instance.textBaseline],
    };

const _$TextDirectionEnumMap = {
  TextDirection.rtl: 'rtl',
  TextDirection.ltr: 'ltr',
};

const _$TableCellVerticalAlignmentEnumMap = {
  TableCellVerticalAlignment.top: 'top',
  TableCellVerticalAlignment.middle: 'middle',
  TableCellVerticalAlignment.bottom: 'bottom',
  TableCellVerticalAlignment.baseline: 'baseline',
  TableCellVerticalAlignment.fill: 'fill',
  TableCellVerticalAlignment.intrinsicHeight: 'intrinsicHeight',
};

const _$TextBaselineEnumMap = {
  TextBaseline.alphabetic: 'alphabetic',
  TextBaseline.ideographic: 'ideographic',
};

_$MiraiTableRowImpl _$$MiraiTableRowImplFromJson(Map<String, dynamic> json) =>
    _$MiraiTableRowImpl(
      decoration: json['decoration'] == null
          ? null
          : MiraiBoxDecoration.fromJson(
              json['decoration'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MiraiTableRowImplToJson(_$MiraiTableRowImpl instance) =>
    <String, dynamic>{
      'decoration': instance.decoration,
      'children': instance.children,
    };

_$MiraiTableBorderImpl _$$MiraiTableBorderImplFromJson(
        Map<String, dynamic> json) =>
    _$MiraiTableBorderImpl(
      top: json['top'] == null
          ? null
          : MiraiBorderSide.fromJson(json['top'] as Map<String, dynamic>),
      right: json['right'] == null
          ? null
          : MiraiBorderSide.fromJson(json['right'] as Map<String, dynamic>),
      bottom: json['bottom'] == null
          ? null
          : MiraiBorderSide.fromJson(json['bottom'] as Map<String, dynamic>),
      left: json['left'] == null
          ? null
          : MiraiBorderSide.fromJson(json['left'] as Map<String, dynamic>),
      horizontalInside: json['horizontalInside'] == null
          ? null
          : MiraiBorderSide.fromJson(
              json['horizontalInside'] as Map<String, dynamic>),
      verticalInside: json['verticalInside'] == null
          ? null
          : MiraiBorderSide.fromJson(
              json['verticalInside'] as Map<String, dynamic>),
      borderRadius: json['borderRadius'] == null
          ? null
          : MiraiBorderRadius.fromJson(json['borderRadius']),
    );

Map<String, dynamic> _$$MiraiTableBorderImplToJson(
        _$MiraiTableBorderImpl instance) =>
    <String, dynamic>{
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'left': instance.left,
      'horizontalInside': instance.horizontalInside,
      'verticalInside': instance.verticalInside,
      'borderRadius': instance.borderRadius,
    };

_$MiraiTableColumnWidthImpl _$$MiraiTableColumnWidthImplFromJson(
        Map<String, dynamic> json) =>
    _$MiraiTableColumnWidthImpl(
      type: $enumDecodeNullable(
              _$MiraiTableColumnWidthTypeEnumMap, json['type']) ??
          MiraiTableColumnWidthType.flexColumnWidth,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MiraiTableColumnWidthImplToJson(
        _$MiraiTableColumnWidthImpl instance) =>
    <String, dynamic>{
      'type': _$MiraiTableColumnWidthTypeEnumMap[instance.type]!,
      'value': instance.value,
    };

const _$MiraiTableColumnWidthTypeEnumMap = {
  MiraiTableColumnWidthType.fixedColumnWidth: 'fixedColumnWidth',
  MiraiTableColumnWidthType.flexColumnWidth: 'flexColumnWidth',
  MiraiTableColumnWidthType.fractionColumnWidth: 'fractionColumnWidth',
  MiraiTableColumnWidthType.intrinsicColumnWidth: 'intrinsicColumnWidth',
};
