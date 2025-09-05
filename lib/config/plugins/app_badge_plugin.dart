/*
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgePlugin {

  static Future<bool> isSupported() {
    return FlutterAppBadger.isAppBadgeSupported();
  }

  static void updateBadge(int count) async {

    if ( !await isSupported() ) {
      debugPrint('Badges are not supported');
      return;
    }

    FlutterAppBadger.updateBadgeCount(count);
    if (count == 0) removeBadge();
  }
  
  static void removeBadge() async {
    if ( !await isSupported() ) {
      debugPrint('Badges are not supported');
      return;
    }
    FlutterAppBadger.removeBadge();
  }
} */