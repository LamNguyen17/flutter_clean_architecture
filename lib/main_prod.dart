import 'package:flutter_clean_architecture/common/helper/flavor_config.dart';
import 'package:flutter_clean_architecture/data/config/app_config.dart';
import 'package:flutter_clean_architecture/di/injection.dart';

void main() async {
  await configureDI();
  FlavorConfig(
    flavor: Flavor.prod,
    values: FlavorValues(baseUrl: AppConfig().endPointProduction),
  );
}