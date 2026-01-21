import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// Base class for all use cases
///
/// [Type] - The return type of the use case
/// [Params] - The parameters required by the use case
// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case with no parameters
// ignore: avoid_types_as_parameter_names
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// For use cases that don't require parameters
class NoParams {
  const NoParams();
}
