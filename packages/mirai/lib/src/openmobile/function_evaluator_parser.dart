import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mirai/src/openmobile/openmobile_functions.dart';

typedef FunctionEvaluatorFunction = dynamic Function(List<dynamic> params);

class FunctionEvaluatorParser {
  final BuildContext context;
  final Map<String, FunctionEvaluatorFunction> _functions = {};

  FunctionEvaluatorParser(this.context) {
    _initializeFunctions();
  }

  void _initializeFunctions() {
    _functions['condition'] = _condition;
    _functions['concat'] = _concat;
    _functions['not_null'] = _notNull;
    _functions['equal'] = _equal;
    _functions['not_equal'] = _notEqual;
    _functions['greater_than'] = _greaterThan;
    _functions['less_than'] = _lessThan;
    _functions['greater_or_equal'] = _greaterOrEqual;
    _functions['less_or_equal'] = _lessOrEqual;
    _functions['is_null'] = _isNull;
    _functions['and'] = _and;
    _functions['or'] = _or;
    _functions['not'] = _not;
    _functions['in_list'] = _inList;
    _functions['object_storage'] = _objectStorage;
    _functions['param'] = _param;
    _functions['storage'] = _storage;
    _functions['secureStorage'] = _secureStorage;
    _functions['network'] = _network;
    _functions['state'] = _state;
    _functions['format_money'] = _formatMoney;
    _functions['to_string'] = _toString;
    _functions['format_date'] = _formatDate;
  }

  dynamic evaluate(Map<String, dynamic> function) {
    final functionType = function['functionType'];
    final params = function['params'].map((param) {
      if (param is Map<String, dynamic> && param.containsKey('functionType')) {
        return evaluate(param);
      } else {
        return param;
      }
    }).toList();

    if (_functions.containsKey(functionType)) {
      final value = _functions[functionType]!(params);
      return value;
    } else {
      throw UnsupportedError('Unsupported function type: $functionType');
    }
  }

  Map<String, dynamic> evaluateMap(Map<String, dynamic> map) {
    Map<String, dynamic> evaluatedMap = {};

    map.forEach((key, value) {
      if (key == 'child' || key == 'children') {
        evaluatedMap[key] = value;
      } else if (value is Map<String, dynamic>) {
        if (value.containsKey('functionType')) {
          evaluatedMap[key] = evaluate(value);
        } else {
          evaluatedMap[key] = evaluateMap(value);
        }
      } else if (value is List) {
        evaluatedMap[key] = value.map((item) {
          if (item is Map<String, dynamic>) {
            return evaluateMap(item);
          } else {
            return item;
          }
        }).toList();
      } else {
        evaluatedMap[key] = value;
      }
    });

    return evaluatedMap;
  }

  dynamic _condition(List<dynamic> params) {
    if (params.length < 3) {
      throw RangeError('Insufficient parameters for condition function');
    }
    return params[0] ? params[1] : params[2];
  }

  String _concat(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for concat function');
    }
    return params.join();
  }

  bool _notNull(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for not_null function');
    }
    return params[0] != null;
  }

  bool _equal(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for equal function');
    }
    return params[0] == params[1];
  }

  bool _notEqual(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for not_equal function');
    }
    return params[0] != params[1];
  }

  bool _greaterThan(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for greater_than function');
    }
    return params[0] > params[1];
  }

  bool _lessThan(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for less_than function');
    }
    return params[0] < params[1];
  }

  bool _greaterOrEqual(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for greater_or_equal function');
    }
    return params[0] >= params[1];
  }

  bool _lessOrEqual(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for less_or_equal function');
    }
    return params[0] <= params[1];
  }

  bool _isNull(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for is_null function');
    }
    return params[0] == null;
  }

  bool _and(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for and function');
    }
    for (var param in params) {
      if (param is Map<String, dynamic> && param.containsKey('functionType')) {
        if (!evaluate(param)) {
          return false;
        }
      } else if (!param) {
        return false;
      }
    }
    return true;
  }

  bool _or(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for or function');
    }
    for (var param in params) {
      if (param is Map<String, dynamic> && param.containsKey('functionType')) {
        if (evaluate(param)) {
          return true;
        }
      } else if (param) {
        return true;
      }
    }
    return false;
  }

  bool _not(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for not function');
    }
    if (params[0] is Map<String, dynamic> && params[0].containsKey('functionType')) {
      return !evaluate(params[0]);
    } else {
      return !params[0];
    }
  }

  bool _inList(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for in_list function');
    }
    if (params[1] is List) {
      return params[1].contains(params[0]);
    } else {
      throw ArgumentError('Second parameter for in_list function must be a List');
    }
  }

  dynamic _objectStorage(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for object_storage function');
    }
    return OpenmobileFunctions.getObjectFromLocalStorage(context, params[0]);
  }

  dynamic _param(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for param function');
    }
    return OpenmobileFunctions.getFromParams(context, params[0]);
  }

  dynamic _storage(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for storage function');
    }
    return OpenmobileFunctions.getFromStorage(context, params[0]);
  }

  dynamic _secureStorage(List<dynamic> params) async {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for storage function');
    }
    return OpenmobileFunctions.getFromSecureStorage(context, params[0]);
  }

  dynamic _network(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for network function');
    }
    return OpenmobileFunctions.getFromNetwork(context, params[0]);
  }

  dynamic _state(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for state function');
    }
    return OpenmobileFunctions.getFromLocalState(context, params[0]);
  }

  String _formatMoney(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for formatMoney function');
    }
    return OpenmobileFunctions.formatMoney(context, params[0], params[1]);
  }

  String _formatDate(List<dynamic> params) {
    if (params.length < 2) {
      throw RangeError('Insufficient parameters for formatMoney function');
    }
    return params.length == 2
        ? OpenmobileFunctions.formatDate(params[0], params[1])
        : OpenmobileFunctions.formatDate(params[0], params[1], locale: params[2]);
  }

  dynamic _toString(List<dynamic> params) {
    if (params.isEmpty) {
      throw RangeError('Insufficient parameters for to_string function');
    }
    var param = params[0];
    if (param is Map) {
      return jsonEncode(param);
    } else if (param is String) {
      return param;
    } else {
      return param.toString();
    }
  }
}
