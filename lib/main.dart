import 'dart:async';
import 'dart:isolate';

import 'package:esync_app/core/dependency_registrar/dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bloc/app_bloc_observer.dart';

void main() {
  //get errors that happend outside of flutter zone
  Isolate.current.addErrorListener(
    RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort,
  );
  BlocOverrides.runZoned(
    () async {
      slInit();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );
}
