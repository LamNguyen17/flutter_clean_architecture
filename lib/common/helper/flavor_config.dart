import 'package:flutter/material.dart';

enum Flavor {
  dev, prod
}

class FlavorValues {
  final String baseUrl;

  FlavorValues({required this.baseUrl});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color colorPrimary;
  final Color colorPrimaryDark;
  final Color colorPrimaryLight;
  final Color colorAccent;
  final FlavorValues values;
  static dynamic _instance;

  factory FlavorConfig({
    required Flavor flavor,
    Color colorPrimary = Colors.blue,
    Color colorPrimaryDark = Colors.blue,
    Color colorPrimaryLight = Colors.blue,
    Color colorAccent = Colors.blueAccent,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      colorPrimary,
      colorPrimaryDark,
      colorPrimaryLight,
      colorAccent,
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(
      this.flavor,
      this.name,
      this.colorPrimary,
      this.colorPrimaryDark,
      this.colorPrimaryLight,
      this.colorAccent,
      this.values,
      );

  static FlavorConfig get instance {
    return _instance;
  }

  static String enumName(String enumToString) {
    var paths = enumToString.split('.');
    return paths[paths.length - 1];
  }

  static bool isProduction() => _instance.flavor == Flavor.prod;

  static bool isDevelopment() => _instance.flavor == Flavor.dev;
}
