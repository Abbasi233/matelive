import 'user_detail.dart';

class Action {
  Action({
    this.id,
    this.message,
    this.relatedUser,
    this.createdAt,
  });

  int id;
  String message;
  UserDetail relatedUser;
  DateTime createdAt;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json["id"],
        message: json["message"],
        relatedUser: UserDetail.fromJson(json["related_user"]),
        createdAt: DateTime.parse(json["created_at"]),
      );
}
