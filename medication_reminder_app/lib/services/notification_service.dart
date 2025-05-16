import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
    String medicationName,
    String dosage,
    DateTime time, {
    String? sound,
    bool vibration = true,
    String? customMessage,
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'medication_channel',
        'Canal de Lembretes de Medicamentos',
        channelDescription: 'Canal para lembretes de medicamentos',
        sound:
            sound != null ? RawResourceAndroidNotificationSound(sound) : null,
        enableVibration: vibration,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _notificationsPlugin.zonedSchedule(
      0,
      'Lembrete de Medicamento',
      customMessage ?? 'Hora de tomar $medicationName ($dosage)',
      tz.TZDateTime.from(time, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time, // Ensure daily reminders
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
