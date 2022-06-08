import 'dart:convert';

import 'package:matelive/model/user_detail.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.id,
    this.roomId,
    this.senderId,
    this.sender,
    this.receiverId,
    this.receiver,
    this.message,
    this.attachments,
    this.isReadByReceiver,
    this.isDeleted,
    this.updatedAt,
    this.sending = false,
  });

  int id;
  int roomId;
  int senderId;
  UserDetail sender;
  int receiverId;
  UserDetail receiver;
  String message;
  List<String> attachments;
  bool isReadByReceiver;
  int isDeleted;
  DateTime updatedAt;
  bool sending;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        roomId: json["room_id"],
        senderId: json["sender_id"],
        sender:
            json["sender"] != null ? UserDetail.fromJson(json["sender"]) : null,
        receiverId: json["receiver_id"],
        receiver: json["sender"] != null
            ? UserDetail.fromJson(json["receiver"])
            : null,
        message: json["message"],
        attachments: List<String>.from(json["attachments"].map((x) => x)),
        isReadByReceiver: json["is_read_by_receiver"] == 1 ? true : false,
        isDeleted: json["is_deleted"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "is_read_by_receiver": isReadByReceiver,
        "is_deleted": isDeleted,
        "updated_at": updatedAt.toIso8601String(),
      };
}
