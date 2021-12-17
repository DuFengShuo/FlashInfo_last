// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

///消耗品的仓库。
///这是一个开发原型，存储在共享的消耗品
///偏好。不要在现实世界的应用程序中使用这个。
class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future.value();

  ///将ID为ID的消费品添加到存储中。
  ///只在返回的Future完成后添加消费品。
  static Future<void> save(String id) {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  ///使用存储中ID为' ID '的消耗品。
  ///只在返回的Future完成后才使用。
  static Future<void> consume(String id) {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  ///返回商店中的消耗品列表
  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        [];
  }

  static Future<void> _doSave(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}
