
import 'package:esync_app/core/dependency_registrar/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bloc/app_bloc_observer.dart';

void main() {
  //get errors that happend outside of flutter zone
  // Isolate.current.addErrorListener(
  //   RawReceivePort((pair) async {
  //     final List<dynamic> errorAndStacktrace = pair;
  //     await FirebaseCrashlytics.instance.recordError(
  //       errorAndStacktrace.first,
  //       errorAndStacktrace.last,
  //     );
  //   }).sendPort,
  // );
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await slInit();
      // await Firebase.initializeApp();
      runApp(const App());
    },
    blocObserver: AppBlocObserver(),
  );
}
