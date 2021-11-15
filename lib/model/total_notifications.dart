class TotalNotifications {
  TotalNotifications({
    this.totalUnreadNotificationCount,
    this.totalNotificationCount,
    this.systemNotificationCount,
    this.favoriteNotificationCount,
    this.snoozeNotificationCount,
    this.likeNotificationCount,
  });

  int totalUnreadNotificationCount;
  int totalNotificationCount;
  int systemNotificationCount;
  int favoriteNotificationCount;
  int snoozeNotificationCount;
  int likeNotificationCount;

  factory TotalNotifications.fromJson(Map<String, dynamic> json) =>
      TotalNotifications(
        totalUnreadNotificationCount: json["total_unread_notification_count"],
        totalNotificationCount: json["total_notification_count"],
        systemNotificationCount: json["system_notification_count"],
        favoriteNotificationCount: json["favorite_notification_count"],
        snoozeNotificationCount: json["snooze_notification_count"],
        likeNotificationCount: json["like_notification_count"],
      );
}
