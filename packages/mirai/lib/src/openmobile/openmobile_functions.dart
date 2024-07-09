import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mirai/src/openmobile/app_state.dart';
import 'package:provider/provider.dart';

class OpenmobileFunctions {
  static dynamic getFromNetwork(BuildContext context, String key) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.getRequest(key);
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
    final jsonString = appState.getStorageValue(key);
    return jsonDecode(jsonString ?? "{}");
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
