abstract class Failure {
  final String message;

  const Failure({required this.message});

  List<Object?> get props => [message];

  @override
  String toString() {
    return message;
  }
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}
