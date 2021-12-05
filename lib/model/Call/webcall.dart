import 'person.dart';

class WebCall {
  WebCall({
    this.id,
    this.callerId,
    this.answererId,
    this.callStartedAt,
    this.callEndedAt,
    this.status,
    this.durationSeconds,
    this.channelName,
    this.endReason,
    this.caller,
    this.answerer,
  });

  int id;
  int callerId;
  int answererId;
  dynamic callStartedAt;
  dynamic callEndedAt;
  dynamic status;
  int durationSeconds;
  String channelName;
  dynamic endReason;
  Person caller;
  Person answerer;

  factory WebCall.fromJson(Map<String, dynamic> json) => WebCall(
        id: json["id"],
        callerId: json["caller_id"],
        answererId: json["answerer_id"],
        callStartedAt: json["call_started_at"],
        callEndedAt: json["call_ended_at"],
        status: json["status"],
        durationSeconds: json["duration_seconds"],
        channelName: json["channel_name"],
        endReason: json["end_reason"],
        caller: json["caller"] == null ? null : Person.fromJson(json["caller"]),
        answerer:
            json["answerer"] == null ? null : Person.fromJson(json["answerer"]),
      );
}
