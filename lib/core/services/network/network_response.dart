
import 'package:task_cast_app/common/models/status.dart';

class NetworkResponse {
  late Status? status;
  late dynamic responseData;

  NetworkResponse.statusResponse(this.status, this.responseData);

  NetworkResponse.response(this.responseData);
}
