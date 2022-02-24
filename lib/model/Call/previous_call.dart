import 'person.dart';

class PreviousCall {
  PreviousCall({
    this.caller,
    this.answerer,
    this.callStartedAt,
    this.callEndedAt,
    this.status,
    this.durationSeconds,
    this.channelName,
    this.endReason,
    this.isExpanded = false,
  });

  Person caller;
  Person answerer;
  DateTime callStartedAt;
  DateTime callEndedAt;
  int status;
  int durationSeconds;
  String channelName;
  String endReason;
  bool isExpanded;

  factory PreviousCall.fromJson(Map<String, dynamic> json) => PreviousCall(
        caller: Person.fromJson(json["caller"]),
        answerer: Person.fromJson(json["answerer"]),
        callStartedAt: json["call_started_at"] == null
            ? DateTime.parse(json["created_at"])
            : DateTime.parse(json["call_started_at"]),
        callEndedAt: json["call_ended_at"] == null
            ? null
            : DateTime.parse(json["call_ended_at"]),
        status: json["status"],
        durationSeconds: json["duration_seconds"],
        channelName: json["channel_name"],
        endReason: json["end_reason"],
      );
}
