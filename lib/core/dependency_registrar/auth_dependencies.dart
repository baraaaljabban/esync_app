import 'package:esync_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:esync_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:esync_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:esync_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:esync_app/features/authentication/domain/usecases/sign_up.dart';
import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> authDependencies(GetIt sl) async {
  sl.registerFactory(
    () => AuthenticationBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
    ),
  );

  sl.registerFactory(() => SignIn(repository: sl()));
  sl.registerFactory(() => SignUp(repository: sl()));

  sl.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      connectionChecker: sl(),
      // localDataSource:  sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerFactory<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(),
  );
}
