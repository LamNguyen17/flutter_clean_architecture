import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $message}';
  }
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

abstract class BaseUseCase<Type, Params>{
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}