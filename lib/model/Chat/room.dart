import 'dart:convert';

import '/model/user_detail.dart';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

class Room {
  Room({
    this.id,
    this.user,
    this.lastMessage,
    this.messageCount,
    this.createdAt,
    this.updatedAt,
    this.isRead = false,
  });

  int id;
  UserDetail user;
  String lastMessage;
  int messageCount;
  DateTime createdAt;
  DateTime updatedAt;
  bool isRead;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        user: UserDetail.fromJson(json["user"]),
        lastMessage: json["last_message"],
        messageCount: json["message_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isRead: json["is_read"],
      );
}
