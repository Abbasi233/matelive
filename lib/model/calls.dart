class Calls {
  Calls({
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

  factory Calls.fromJson(Map<String, dynamic> json) => Calls(
        caller: Person.fromJson(json["caller"]),
        answerer: Person.fromJson(json["answerer"]),
        callStartedAt: json["call_started_at"] == null
            ? null
            : DateTime.parse(json["call_started_at"]),
        callEndedAt: json["call_ended_at"] == null
            ? null
            : DateTime.parse(json["call_ended_at"]),
        status: json["status"],
        durationSeconds: json["duration_seconds"],
        channelName: json["channel_name"],
        endReason: json["end_reason"],
      );

  Map<String, dynamic> toJson() => {
        "caller": caller.toJson(),
        "answerer": answerer.toJson(),
        "call_started_at":
            callStartedAt == null ? null : callStartedAt.toIso8601String(),
        "call_ended_at": callEndedAt.toIso8601String(),
        "status": status,
        "duration_seconds": durationSeconds,
        "channel_name": channelName,
        "end_reason": endReason,
      };
}

class Person {
  Person({
    this.id,
    this.name,
    this.surname,
    this.image,
  });

  int id;
  String name;
  String surname;
  String image;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "image": image,
      };
}
