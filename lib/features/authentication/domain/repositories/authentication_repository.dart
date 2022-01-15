import 'package:dartz/dartz.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/authentication/domain/entities/auth_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationEntity>> signIn({required String email, required String password});

  Future<Either<Failure, AuthenticationEntity>> signUp({required String email, required String password});
}
