import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medication_reminder_app/services/notification_service.dart';

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  group('NotificationService', () {
    late MockNotificationService mockNotificationService;

    setUp(() {
      mockNotificationService = MockNotificationService();
    });

    test('should schedule a notification', () async {
      // Arrange
      const medicationName = 'Aspirin';
      const dosage = '100mg';
      final time = DateTime.now().add(const Duration(hours: 1));

      // Act
      await mockNotificationService.scheduleNotification(
        medicationName,
        dosage,
        time,
      );

      // Assert
      verify(
        mockNotificationService.scheduleNotification(
          medicationName,
          dosage,
          time,
        ),
      ).called(1);
    });

    test('should cancel a scheduled notification', () async {
      // Arrange
      const notificationId = 1;

      // Act
      await mockNotificationService.cancelNotification(notificationId);

      // Assert
      verify(
        mockNotificationService.cancelNotification(notificationId),
      ).called(1);
    });
  });
}
