import 'package:flutter/material.dart';
import 'package:mirai/src/parsers/mirai_mirai_spacer/mirai_mirai_spacer.dart';
import 'package:mirai/src/utils/widget_type.dart';
import 'package:mirai_framework/mirai_framework.dart';

class MiraiMiraiSpacerParser extends MiraiParser<MiraiMiraiSpacer> {
  const MiraiMiraiSpacerParser();

  @override
  MiraiMiraiSpacer getModel(Map<String, dynamic> json) =>
      MiraiMiraiSpacer.fromJson(json);

  @override
  String get type => WidgetType.spacer.name;

  @override
  Widget parse(BuildContext context, MiraiMiraiSpacer model) {
    return Spacer(flex: model.flex);
  }
}
