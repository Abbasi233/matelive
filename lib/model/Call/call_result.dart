import 'webcall.dart';

class CallResult {
  CallResult({
    this.status,
    this.message,
    this.webcall,
  });

  String status;
  String message;
  WebCall webcall;

  factory CallResult.fromJson(Map<String, dynamic> json) => CallResult(
        status: json["status"],
        message: json["message"],
        webcall: WebCall.fromJson(json["webcall"]),
      );
}
