class Notification {
  Notification(dynamic item) {
    notificationTime = item['pushNotificationTime'];
    isNotifiacationOn = item['on'];
  }

  late int notificationTime;
  late bool isNotifiacationOn;
}
