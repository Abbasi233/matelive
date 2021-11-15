class Notification {
  Notification({
    this.id,
    this.message,
    this.link,
    this.type,
    this.isRead,
    this.createdAt,
    this.createdAtFormatted,
  });

  int id;
  String message;
  String link;
  int type;
  int isRead;
  String createdAt;
  String createdAtFormatted;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        message: json["message"],
        link: json["link"],
        type: json["type"],
        isRead: json["is_read"],
        createdAt: json["created_at"],
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "link": link,
        "type": type,
        "is_read": isRead,
        "created_at": createdAt,
        "created_at_formatted": createdAtFormatted,
      };
}
