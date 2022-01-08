import 'package:esync_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> homeDependencies(GetIt sl) async {

  sl.registerFactory(
        () => HomeBloc(
      // tillListUseCase: sl(),
      // closeTillUseCase: sl(),
    ),
  );
}