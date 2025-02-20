import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  Map<String, dynamic> _requests = {};
  Map<String, dynamic> _params = {};
  Map<String, dynamic> _localState = {};

  Map<String, Map<String, dynamic>> _components = {};
  Map<String, Completer<Map<String, dynamic>?>> _componentCompleters = {};
  SharedPreferences? _prefs;
  FlutterSecureStorage? _secureStorage;

  Map<String, dynamic> get requests => _requests;
  Map<String, dynamic> get params => _params;
  Map<String, dynamic> get localState => _localState;
  SharedPreferences? get prefs => _prefs;

  AppState() {
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
  }

  void updateRequest(String key, dynamic value) {
    _requests[key] = value;
    // notifyListeners();
  }

  void updateParam(String key, dynamic value) {
    _params[key] = value;
    // notifyListeners();
  }

  void updateParams(Map<String, dynamic> params) {
    _params = params;
    // notifyListeners();
  }

  void updateLocalState(String key, dynamic value) {
    _localState[key] = value;
    // notifyListeners();
  }

  void updateComponent(String key, Map<String, dynamic> component) {
    _components[key] = component;
    // notifyListeners();
  }

  Future<void> setValueToStorage(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<void> setValueToSecureStorage(String key, String value) async {
    await _secureStorage?.write(key: key, value: value);
  }

  dynamic getRequest(String key) {
    return _requests[key];
  }

  dynamic getParam(String key) {
    return _params[key];
  }

  dynamic getLocalState(String key) {
    return _localState[key];
  }

  String? getStorageValue(String key) {
    return _prefs?.getString(key);
  }

  Future<String?> getSecureStorageValue(String key) async {
    return await _secureStorage?.read(key: key);
  }

  Map<String, dynamic>? getComponent(String key) {
    return _components[key];
  }

  Completer<Map<String, dynamic>?> getComponentCompleter(String id) {
    return _componentCompleters.putIfAbsent(id, () => Completer<Map<String, dynamic>?>());
  }

  void clearRequests() {
    _requests.clear();
    notifyListeners();
  }

  void clearParams() {
    _params.clear();
    notifyListeners();
  }

  void clearLocalState() {
    _localState.clear();
    notifyListeners();
  }

  void clearSecureStorage() async {
    await _secureStorage?.deleteAll();
    notifyListeners();
  }

  void clearComponents() {
    _components.clear();
    notifyListeners();
  }
}
