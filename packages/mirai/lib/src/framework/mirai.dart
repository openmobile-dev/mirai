import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai/mirai.dart';
import 'package:mirai/src/action_parsers/mirai_network_request/mirai_network_request_parser.dart';
import 'package:mirai/src/openmobile/function_evaluator_parser.dart';
import 'package:mirai/src/services/mirai_network_service.dart';
import 'package:mirai/src/utils/log.dart';

typedef ErrorWidgetBuilder = Widget Function(
  BuildContext context,
  dynamic error,
);

typedef LoadingWidgetBuilder = Widget Function(BuildContext context);

class Mirai {
  static final _parsers = <MiraiParser>[
    const MiraiContainerParser(),
    const MiraiTextParser(),
    const MiraiTextFieldParser(),
    const MiraiElevatedButtonParser(),
    const MiraiImageParser(),
    const MiraiIconParser(),
    const MiraiCenterParser(),
    const MiraiRowParser(),
    const MiraiColumnParser(),
    const MiraiStackParser(),
    const MiraiPositionedParser(),
    const MiraiIconButtonParser(),
    const MiraiFloatingActionButtonParser(),
    const MiraiOutlinedButtonParser(),
    const MiraiPaddingParser(),
    const MiraiAppBarParser(),
    const MiraiTextButtonParser(),
    const MiraiScaffoldParser(),
    const MiraiSizedBoxParser(),
    const MiraiFractionallySizedBoxParser(),
    const MiraiTextFormFieldParser(),
    const MiraiTabBarViewParser(),
    const MiraiTabBarParser(),
    const MiraiListTileParser(),
    const MiraiCardParser(),
    const MiraiBottomNavigationBarParser(),
    const MiraiListViewParser(),
    const MiraiDefaultTabControllerParser(),
    const MiraiSingleChildScrollViewParser(),
    const MiraiAlertDialogParser(),
    const MiraiTabParser(),
    const MiraiFormParser(),
    const MiraiCheckBoxWidgetParser(),
    const MiraiExpandedParser(),
    const MiraiFlexibleParser(),
    const MiraiSafeAreaParser(),
    const MiraiSwitchParser(),
    const MiraiAlignParser(),
    const MiraiPageViewParser(),
    const MiraiRefreshIndicatorParser(),
    const MiraiNetworkWidgetParser(),
    const MiraiCircleAvatarParser(),
    const MiraiChipParser(),
    const MiraiGridViewParser(),
    const MiraiFilledButtonParser(),
    const MiraiBottomNavigationViewParser(),
    const MiraiDefaultBottomNavigationControllerParser(),
    const MiraiWrapParser(),
  ];

  static final _actionParsers = <MiraiActionParser>[
    const MiraiNoneActionParser(),
    const MiraiNavigateActionParser(),
    const MiraiNetworkRequestParser(),
    const MiraiModalBottomSheetActionParser(),
    const MiraiDialogActionParser(),
    const MiraiGetFormValueParser(),
    const MiraiFormValidateParser(),
  ];

  static Future<void> initialize({
    List<MiraiParser> parsers = const [],
    List<MiraiActionParser> actionParsers = const [],
    Dio? dio,
  }) async {
    _parsers.addAll(parsers);
    _actionParsers.addAll(actionParsers);
    MiraiRegistry.instance.registerAll(_parsers);
    MiraiRegistry.instance.registerAllActions(_actionParsers);
    MiraiNetworkService.initialize(dio ?? Dio());
  }

  static Future<void> executeOnLoad(Map<String, dynamic>? onLoad, BuildContext context) async {
    if (onLoad != null && context.mounted) {
      await Mirai.onCallFromJson(onLoad, context);
    }
  }

  static Widget? fromJson(Map<String, dynamic>? json, BuildContext context) {
    String widgetType = 'unknown';
    if (json == null) {
      return null;
    }
    try {
      var mutableJson = Map<String, dynamic>.from(json);
      widgetType = mutableJson['type'];

      // Log.i('Widget type: $widgetType');
      MiraiParser? miraiParser = MiraiRegistry.instance.getParser(widgetType);

      if (miraiParser == null) {
        Log.w('Widget type [$widgetType] not supported');
        return null;
      }

      final evaluator = FunctionEvaluatorParser(context);
      mutableJson = _processQueryAttribute(context, evaluator, mutableJson);
      if (mutableJson.containsKey('onLoad')) {
        // Log.i('Executing onLoad actions');
        return _buildFutureWidget(context, miraiParser, evaluator, mutableJson);
      } else {
        return _buildWidget(context, miraiParser, evaluator, mutableJson);
      }
    } catch (e) {
      Log.e('WidgetType $widgetType cause unexpected error: $e');
      return null;
    }
  }

  static Map<String, dynamic> _processQueryAttribute(
    BuildContext context,
    FunctionEvaluatorParser evaluator,
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('query')) {
      final query = json['query'];
      final items = evaluator.evaluate(query);
      final template = json['children']?.first;

      if (template != null) {
        OpenmobileFunctionEvaluator evaluator = OpenmobileFunctionEvaluator();
        List<Map<String, dynamic>> childrenWidgets = [];

        for (var item in items) {
          if (item is Map<String, dynamic>) {
            final evaluatedTemplate = evaluator.replaceItemAttributes(Map<String, dynamic>.from(template), item);
            childrenWidgets.add(evaluatedTemplate);
          } else {
            throw UnsupportedError('Unsupported item type: ${item.runtimeType}');
          }
        }

        json['children'] = childrenWidgets;
        json.remove('query');
      }
    }
    return json;
  }

  static Widget _buildFutureWidget(
    BuildContext context,
    MiraiParser miraiParser,
    FunctionEvaluatorParser evaluator,
    Map<String, dynamic> json,
  ) {
    return FutureBuilder<void>(
      future: executeOnLoad(json['onLoad'], context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // ShimmerLoading()
          return Center(child: Text('Loading Future Widget...'));
        }

        if (snapshot.hasError) {
          Log.e('Error in FutureBuilder: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        try {
          return _buildWidget(context, miraiParser, evaluator, json);
        } catch (e) {
          Log.e('Error during evaluation or parsing: $e');
          return Center(child: Text('Error: $e'));
        }
      },
    );
  }

  static Widget _buildWidget(
    BuildContext context,
    MiraiParser miraiParser,
    FunctionEvaluatorParser evaluator,
    Map<String, dynamic> json,
  ) {
    try {
      final evaluatedJson = evaluator.evaluateMap(json);
      final model = miraiParser.getModel(evaluatedJson);
      return miraiParser.parse(context, model);
    } catch (e) {
      Log.e('Error during evaluation or parsing: $e');
      return Center(child: Text('Error: $e'));
    }
  }

  static FutureOr<dynamic> onCallFromJson(
    Map<String, dynamic>? json,
    BuildContext context,
  ) {
    try {
      if (json != null && json['actionType'] != null) {
        String actionType = json['actionType'];
        MiraiActionParser? miraiActionParser = MiraiRegistry.instance.getActionParser(actionType);
        if (miraiActionParser != null) {
          final evaluator = FunctionEvaluatorParser(context);
          final evaluatedJson = evaluator.evaluateMap(json);
          final model = miraiActionParser.getModel(evaluatedJson);
          return miraiActionParser.onCall(context, model);
        } else {
          Log.w('Action type [$actionType] not supported');
        }
      }
    } catch (e) {
      Log.e(e);
    }
    return null;
  }

  static Widget fromNetwork({
    required BuildContext context,
    required MiraiNetworkRequest request,
    LoadingWidgetBuilder? loadingWidget,
    ErrorWidgetBuilder? errorWidget,
  }) {
    return FutureBuilder<Response?>(
      future: MiraiNetworkService.request(context, request),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            Widget? widget;
            if (loadingWidget != null) {
              widget = loadingWidget(context);
              return widget;
            }
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              final json = jsonDecode(snapshot.data.toString());
              return Mirai.fromJson(json, context) ?? const SizedBox();
            } else if (snapshot.hasError) {
              Log.e(snapshot.error);
              if (errorWidget != null) {
                final widget = errorWidget(context, snapshot.error);
                return widget;
              }
            }
            break;
          default:
            break;
        }
        return const SizedBox();
      },
    );
  }

  static Widget? fromAssets(
    String assetPath, {
    LoadingWidgetBuilder? loadingWidget,
    ErrorWidgetBuilder? errorWidget,
  }) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            Widget? widget;
            if (loadingWidget != null) {
              widget = loadingWidget(context);
              return widget;
            }
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              final json = jsonDecode(snapshot.data.toString());
              return Mirai.fromJson(json, context) ?? const SizedBox();
            } else if (snapshot.hasError) {
              Log.e(snapshot.error);
              if (errorWidget != null) {
                final widget = errorWidget(context, snapshot.error);
                return widget;
              }
            }
            break;
          default:
            break;
        }
        return const SizedBox();
      },
    );
  }
}

extension MiraiExtension on Widget? {
  PreferredSizeWidget? get toPreferredSizeWidget {
    if (this != null) {
      return this as PreferredSizeWidget;
    }
    return null;
  }
}
