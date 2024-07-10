import 'dart:async';

import 'package:flutter/material.dart';

import 'openmobile_functions.dart';

typedef FunctionEvaluator = dynamic Function(BuildContext context, List<dynamic> params);
typedef AsyncFunctionEvaluator = Future<dynamic> Function(BuildContext context, String key);

class OpenmobileFunctionEvaluator {
  static final OpenmobileFunctionEvaluator _instance = OpenmobileFunctionEvaluator._internal();
  final Map<String, FunctionEvaluator> _functions = {};

  factory OpenmobileFunctionEvaluator() {
    return _instance;
  }

  OpenmobileFunctionEvaluator._internal() {
    _initializeFunctions();
  }

  void _initializeFunctions() {
    _functions['param'] = (context, params) => OpenmobileFunctions.getFromParams(
          context,
          params[0],
        );
    _functions['storage'] = (context, params) => OpenmobileFunctions.getFromStorage(
          context,
          params[0],
        );
    _functions['object_storage'] = (context, params) => OpenmobileFunctions.getObjectFromLocalStorage(
          context,
          params[0],
        );
    _functions['network'] = (context, params) => OpenmobileFunctions.getFromNetwork(
          context,
          params[0],
        );
    _functions['state'] = (context, params) => OpenmobileFunctions.getFromLocalState(
          context,
          params[0],
        );
    _functions['formatMoney'] = (context, params) => OpenmobileFunctions.formatMoney(
          context,
          params[0],
          params[1],
        );
  }

  /*dynamic evaluate(String functionName, BuildContext context, String key) {
    final function = _functions[functionName];
    if (function != null) {
      if (key.contains(',')) {
        final keys = key.split(',');
        return Function.apply(function, [context, keys]);
      } else {
        if (key.contains('.')) {
          final keys = key.split('.');
          var value = Function.apply(function, [
            context,
            [keys.first]
          ]);
          for (var i = 1; i < keys.length; i++) {
            value = value[keys[i]];
          }
          return value;
        } else {
          return Function.apply(function, [
            context,
            [key]
          ]);
        }
      }
    }
    throw UnsupportedError('Unsupported function: $functionName');
  }*/
/*
  Map<String, dynamic> evaluateJsonFunctions(BuildContext context, Map<String, dynamic> json) {
    var mutableJson = Map<String, dynamic>.from(json);

    mutableJson = _evaluateNestedJson(context, mutableJson);

    return mutableJson;
  }

  Map<String, dynamic> _evaluateNestedJson(BuildContext context, Map<String, dynamic> json) {
    var mutableJson = Map<String, dynamic>.from(json);

    mutableJson.forEach((key, value) {
      if (key == 'child' || key == 'children') {
        mutableJson[key] = value;
        return;
      }

      if (value is String) {
        mutableJson[key] = evaluateJsonFunction(context, value);
      } else if (value is Map<String, dynamic>) {
        mutableJson[key] = _evaluateNestedJson(context, value);
      } else if (value is List<dynamic>) {
        mutableJson[key] = value.map((item) {
          if (item is Map<String, dynamic>) {
            return _evaluateNestedJson(context, item);
          } else if (item is String) {
            return evaluateJsonFunction(context, item);
          }
          return item;
        }).toList();
      }
    });

    return mutableJson;
  }*/

  /*dynamic evaluateJsonFunction(BuildContext context, String value) {
    final match = RegExp(r"fn\.([a-zA-Z_]+)\(([^)]+)\)").firstMatch(value);
    if (match != null) {
      final functionName = match.group(1);
      final functionKey = match.group(2);
      if (functionName != null && functionKey != null) {
        var result = evaluate(functionName, context, functionKey);
        if (result is String || result == null) {
          return value.replaceAll("${match[0]}", "$result");
        }
        return evaluate(functionName, context, functionKey);
      }
    }
    return value;
  }*/

  Map<String, dynamic> replaceItemAttributes(Map<String, dynamic> json, dynamic item) {
    Map<String, dynamic> newJson = {};

    json.forEach((key, value) {
      newJson[key] = replaceItemAttribute(value, item);
    });

    return newJson;
  }

  dynamic replaceItemAttribute(dynamic value, dynamic item) {
    if (value is String) {
      if (value == '{item}') {
        return item;
      } else {
        final regex = RegExp(r'{item(?:\.([^}]+))?}');
        final matches = regex.allMatches(value);

        var newValue = value;

        for (var match in matches) {
          final attributeName = match.group(1);
          final itemValue = attributeName != null ? _getItemAttribute(item, attributeName) : item;

          String replacementValue;

          if (itemValue is String) {
            // TODO(Javi): Check the correct way to handle type of values
            replacementValue = "$itemValue";
          } else if (itemValue is num) {
            replacementValue = itemValue.toString();
          } else {
            replacementValue = itemValue.toString();
          }

          newValue = newValue.replaceFirst(match.group(0)!, replacementValue);
        }

        return newValue;
      }
    } else if (value is Map<String, dynamic>) {
      return replaceItemAttributes(value, item);
    } else if (value is List<dynamic>) {
      return value.map((element) {
        if (element is Map<String, dynamic>) {
          return replaceItemAttributes(element, item);
        } else {
          return replaceItemAttribute(element, item);
        }
      }).toList();
    } else {
      return value;
    }
  }

  dynamic _getItemAttribute(dynamic item, String attributeName) {
    final parts = attributeName.split('.');
    var currentValue = item;
    for (var part in parts) {
      if (currentValue is Map && currentValue.containsKey(part)) {
        currentValue = currentValue[part];
      } else {
        throw Exception('Attribute not found: $attributeName');
      }
    }
    return currentValue;
  }
}
