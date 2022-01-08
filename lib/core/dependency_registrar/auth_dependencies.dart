import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> authDependencies(GetIt sl) async {

  sl.registerFactory(
        () => AuthenticationBloc(
      // tillListUseCase: sl(),
      // closeTillUseCase: sl(),
    ),
  );

  // sl.registerFactory(() => TillListUseCase(repository: sl()));
  // sl.registerFactory(() => CloseTillUseCase(repository: sl()));

  // sl.registerFactory<TillRepository>(
  //       () => TillRepositoryImpl(
  //     tillRemoteDataSource: sl(),
  //     localTillDataSource: sl(),
  //   ),
  // );

  // sl.registerFactory<TillRemoteDataSource>(
  //       () => TillRemoteDataSourceImpl(
  //         client: sl(),
  //       ),
  // );

  // sl.registerFactory<LocalTillDataSource>(
  //       () => LocalTillDataSourceImpl(
  //         sharedPreferences: sl(),
  //   ),
  // );

}
