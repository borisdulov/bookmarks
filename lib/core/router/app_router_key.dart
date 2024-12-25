import 'package:flutter/widgets.dart';

abstract final class AppRouterKey {
  static final rootKey = GlobalKey<NavigatorState>();
  static final authenticatedKey = GlobalKey<NavigatorState>();
}
