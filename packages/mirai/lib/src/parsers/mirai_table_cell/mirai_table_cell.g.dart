// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirai_table_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MiraiTableCellImpl _$$MiraiTableCellImplFromJson(Map<String, dynamic> json) =>
    _$MiraiTableCellImpl(
      verticalAlignment: $enumDecodeNullable(
          _$TableCellVerticalAlignmentEnumMap, json['verticalAlignment']),
      child: json['child'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MiraiTableCellImplToJson(
        _$MiraiTableCellImpl instance) =>
    <String, dynamic>{
      'verticalAlignment':
          _$TableCellVerticalAlignmentEnumMap[instance.verticalAlignment],
      'child': instance.child,
    };

const _$TableCellVerticalAlignmentEnumMap = {
  TableCellVerticalAlignment.top: 'top',
  TableCellVerticalAlignment.middle: 'middle',
  TableCellVerticalAlignment.bottom: 'bottom',
  TableCellVerticalAlignment.baseline: 'baseline',
  TableCellVerticalAlignment.fill: 'fill',
  TableCellVerticalAlignment.intrinsicHeight: 'intrinsicHeight',
};
