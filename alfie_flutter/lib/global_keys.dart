import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scaffoldMessengerKeyProvider = Provider((ref) {
  return GlobalKey<ScaffoldMessengerState>();
});

final navigatorKeyProvider = Provider((ref) {
  return GlobalKey<NavigatorState>(debugLabel: 'root');
});
