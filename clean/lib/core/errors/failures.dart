import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// no internet connection in ur device
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// server can not acceess
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// there is no any data saved
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
