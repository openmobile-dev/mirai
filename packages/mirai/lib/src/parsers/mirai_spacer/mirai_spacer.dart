import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:mirai/src/parsers/mirai_spacer/mirai_spacer_parser.dart';

part 'mirai_spacer.freezed.dart';
part 'mirai_spacer.g.dart';

@freezed
class MiraiSpacer with _$MiraiSpacer {
  const factory MiraiSpacer({
    @Default(1) int flex,
  }) = _MiraiSpacer;

  factory MiraiSpacer.fromJson(Map<String, dynamic> json) =>
      _$MiraiSpacerFromJson(json);
}
