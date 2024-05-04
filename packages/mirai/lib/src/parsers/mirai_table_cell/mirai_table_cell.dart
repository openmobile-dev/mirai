import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'mirai_table_cell_parser.dart';

part 'mirai_table_cell.freezed.dart';
part 'mirai_table_cell.g.dart';

@freezed
class MiraiTableCell with _$MiraiTableCell {
  const factory MiraiTableCell({
    TableCellVerticalAlignment? verticalAlignment,
    Map<String, dynamic>? child,
  }) = _MiraiTableCell;

  factory MiraiTableCell.fromJson(Map<String, dynamic> json) =>
      _$MiraiTableCellFromJson(json);
}
