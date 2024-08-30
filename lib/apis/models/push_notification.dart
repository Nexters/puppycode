class Notification {
  Notification(dynamic item) {
    notificationTime = item['pushNotificationTime'];
    isNotificationOn = item['on'];
  }

  late int notificationTime;
  late bool isNotificationOn;
}
