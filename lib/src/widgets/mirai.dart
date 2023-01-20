import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';
import 'package:mirai/src/utils/log.dart';
import 'package:mirai/src/widgets/mirai_column/mirai_column_parser.dart';
import 'package:mirai/src/widgets/mirai_elevated_button/mirai_elevated_button_parser.dart';

class Mirai {
  static final _miraiWidgetMap = <String, MiraiParser>{};

  static final _parsers = <MiraiParser>[
    MiraiTextParser(),
    MiraiTextFieldParser(),
    MiraiElevatedButtonParser(),
    MiraiColumnParser(),
  ];

  static Future<void> initialize({
    List<MiraiParser> parsers = const [],
  }) async {
    await _initParser(_parsers);
  }

  static Future<void> _initParser(
    List<MiraiParser> miraiParsers,
  ) {
    return Future.forEach(
      miraiParsers,
      (MiraiParser mirai) => _miraiWidgetMap[mirai.type] = mirai,
    );
  }

  static Widget fromJson(Map<String, dynamic> map, BuildContext context) {
    String widgetType = map['type'];
    MiraiParser? miraiParser = _miraiWidgetMap[widgetType];
    if (miraiParser != null) {
      final model = miraiParser.getModel(map);
      return miraiParser.parse(context, model);
    } else {
      Log.w('Widget type [$widgetType] not supported');
      return const SizedBox();
    }
  }
}
