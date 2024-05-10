import 'package:flutter/material.dart';
import 'package:mirai/src/parsers/mirai_spacer/mirai_spacer.dart';
import 'package:mirai/src/utils/widget_type.dart';
import 'package:mirai_framework/mirai_framework.dart';

class MiraiSpacerParser extends MiraiParser<MiraiSpacer> {
  const MiraiSpacerParser();

  @override
  MiraiSpacer getModel(Map<String, dynamic> json) => MiraiSpacer.fromJson(json);

  @override
  String get type => WidgetType.spacer.name;

  @override
  Widget parse(BuildContext context, MiraiSpacer model) {
    return Spacer(flex: model.flex);
  }
}
