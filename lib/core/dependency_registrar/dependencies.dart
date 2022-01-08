import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:esync_app/core/dependency_registrar/auth_dependencies.dart';
import 'package:esync_app/core/dependency_registrar/products_dependencies.dart';
import 'package:esync_app/core/network/connection_checker.dart';
import 'package:esync_app/core/network/http_client.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_dependencies.dart';

final sl = GetIt.instance;

Future<void> slInit() async {
  sl.registerFactory(() => Connectivity());

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(
        connectivity: sl(),
      ));

  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<HttpClient>(
    () => HttpClientImpl(
      sharedPreferences: sl(),
      connectionChecker: sl(),
    ),
  );
  authDependencies(sl);
  homeDependencies(sl);
  productsDependencies(sl);
}
