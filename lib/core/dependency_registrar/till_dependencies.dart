import 'package:get_it/get_it.dart';

Future<void> getTillDependencies(GetIt sl) async {
  //COMMON DEPENDENCIES ARE


  // sl.registerFactory(
  //       () => TillBloc(
  //     tillListUseCase: sl(),
  //     closeTillUseCase: sl(),
  //   ),
  // );

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
