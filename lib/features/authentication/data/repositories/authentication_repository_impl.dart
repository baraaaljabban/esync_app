import 'package:dartz/dartz.dart';
import 'package:esync_app/core/errors/error_handler.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/core/network/connection_checker.dart';
import 'package:esync_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:esync_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:esync_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository with ErrorHandler {
  // final AuthenticationLocalDataSource localDataSource;
  final AuthenticationRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthenticationRepositoryImpl({
    // required this.localDataSource,
    required this.remoteDataSource,
    required this.connectionChecker,
  });
  @override
  Future<Either<Failure, AuthenticationEntity>> signIn({required String email, required String password}) async {
    if (await connectionChecker.isConnected()) {
      try {
        final result = await remoteDataSource.signIn(email: email, password: password);
        return Right(result);
      } on Exception catch (e) {
        return Left(mapCommonExceptionToFailure(e));
      }
    } else {
      return Left(ConnectionUnavailableFailure(message: "No Internet"));
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> signUp({required String email, required String password}) async {
    if (await connectionChecker.isConnected()) {
      try {
        final result = await remoteDataSource.signUp(email: email, password: password);
        return Right(result);
      } on Exception catch (e) {
        return Left(mapCommonExceptionToFailure(e));
      }
    } else {
      return Left(ConnectionUnavailableFailure(message: "No Internet"));
    }
  }
}
