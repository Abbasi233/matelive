import 'dart:convert';

import '/model/user_detail.dart';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

class Room {
  Room({
    this.id,
    this.userOne,
    this.user,
    this.lastMessage,
    this.lastMessageSentBy,
    this.messageCount,
    this.createdAt,
    this.updatedAt,
    this.isRead,
  });

  int id;
  int userOne;
  UserDetail user;
  String lastMessage;
  int lastMessageSentBy;
  int messageCount;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, bool> isRead;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        userOne: json["user_one"],
        user: UserDetail.fromJson(json["user"]),
        lastMessage: json["last_message"],
        lastMessageSentBy: json["last_message_sent_by"],
        messageCount: json["message_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isRead: Map<String, bool>.from(json["is_read"]),
      );
}
