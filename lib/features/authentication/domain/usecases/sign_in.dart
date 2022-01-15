import 'package:dartz/dartz.dart';
import 'package:esync_app/core/base_use_cases.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:esync_app/features/authentication/domain/repositories/authentication_repository.dart';

class SignIn extends UseCase<AuthenticationEntity, SignInParams> {
  AuthenticationRepository repository;

  SignIn({
    required this.repository,
  });

  @override
  Future<Either<Failure, AuthenticationEntity>> call({required SignInParams params}) async {
    return await repository.signIn(email: params.email, password: params.password);
  }
}

class SignInParams {
  const SignInParams({
    required this.email,
    required this.password,
  });
  final String email, password;
}
