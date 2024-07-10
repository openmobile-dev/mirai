import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mirai/src/openmobile/app_state.dart';
import 'package:provider/provider.dart';

class OpenmobileFunctions {
  static dynamic getFromNetwork(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    final keys = key.split('.');
    var value = appState.getRequest(keys.first);
    for (var i = 1; i < keys.length; i++) {
      if (keys[i] == 'length' && value is List) {
        return value.length;
      } else {
        value = value[keys[i]];
      }
    }
    return value;
  }

  static String? getFromParams(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.getParam(key)?.toString();
  }

  static dynamic getFromLocalState(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.getLocalState(key);
  }

  static dynamic getObjectFromLocalStorage(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    final keys = key.split('.');
    final jsonString = appState.getStorageValue(keys.first);
    var value = jsonDecode(jsonString ?? "{}");
    for (var i = 1; i < keys.length; i++) {
      value = value[keys[i]];
    }
    return value;
  }

  static String? getFromStorage(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.getStorageValue(key);
  }

  static String formatMoney(BuildContext context, String amount, String currency) {
    final value = double.parse(amount);
    return '$currency ${value.toStringAsFixed(2)}';
  }
}
