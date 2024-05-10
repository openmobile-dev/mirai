import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:mirai/src/parsers/mirai_mirai_spacer/mirai_mirai_spacer_parser.dart';

part 'mirai_mirai_spacer.freezed.dart';
part 'mirai_mirai_spacer.g.dart';

@freezed
class MiraiMiraiSpacer with _$MiraiMiraiSpacer {
  const factory MiraiMiraiSpacer({
    @Default(1) int flex,
  }) = _MiraiMiraiSpacer;

  factory MiraiMiraiSpacer.fromJson(Map<String, dynamic> json) =>
      _$MiraiMiraiSpacerFromJson(json);
}
