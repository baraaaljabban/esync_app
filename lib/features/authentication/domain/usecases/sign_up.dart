import 'package:dartz/dartz.dart';

import 'package:esync_app/core/base_use_cases.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:esync_app/features/authentication/domain/repositories/authentication_repository.dart';

class SignUp extends UseCase<AuthenticationEntity, SignUpParams> {
  AuthenticationRepository repository;

  SignUp({
    required this.repository,
  });

  @override
  Future<Either<Failure, AuthenticationEntity>> call({required SignUpParams params}) async {
    return await repository.signUp(email: params.email, password: params.password);
  }
}

class SignUpParams {
  const SignUpParams({
    required this.email,
    required this.password,
  });
  final String email, password;

  @override
  String toString() => 'SignUpParams(password: $password)';
}
