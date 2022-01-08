import 'package:dartz/dartz.dart';

import '/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoParamsNoFuture<Type> {
  Either<Failure, Type> call();
}

abstract class UseCaseNoFuture<Type, Params> {
  Either<Failure, Type> call({Params params});
}

abstract class UseCaseNoFutureNoParams<Type> {
  Either<Failure, Type> call();
}
