import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/common/helper/flavor_config.dart';
import 'package:flutter_clean_architecture/data/config/app_config.dart';
import 'package:flutter_clean_architecture/di/injection.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_screen.dart';

void main() async {
  await configureDI();
  FlavorConfig(
    flavor: Flavor.dev,
    values: FlavorValues(baseUrl: AppConfig().endPointDevelopment),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhotoScreen(),
    );
  }
}