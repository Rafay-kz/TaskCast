import '../enums/failure_type.dart';
import '../enums/message_type.dart';

class Failure {
  List? properties = const <dynamic>[];

  late final String message;
  final MessageType messageType;
  final FailureType failureType;

  Failure(
      {required this.message,
        required this.messageType,
        this.failureType = FailureType.general,
        this.properties});
}
