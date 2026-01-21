import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    _isInitialized = true;
  }

  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
  }

  // 1. Daily Expense Reminder
  Future<void> scheduleDailyExpenseReminder({
    required TimeOfDay time,
    String? customMessage,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '💰 Expense Reminder',
      customMessage ?? 'Don\'t forget to log your expenses for today!',
      _nextInstanceOfTime(time.hour, time.minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_expense_reminder',
          'Daily Expense Reminder',
          channelDescription: 'Reminder to log daily expenses',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      // FIXED: Added required androidScheduleMode parameter
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_reminder',
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // 2. Budget Alert
  Future<void> showBudgetAlert({
    required String category,
    required double currentAmount,
    required double budgetLimit,
    required double percentageUsed,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'budget_alerts',
      'Budget Alerts',
      channelDescription: 'Alerts when approaching or exceeding budget limits',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(sound: 'default', presentAlert: true),
    );

    String message;
    if (percentageUsed >= 100) {
      message = '⚠️ You\'ve exceeded your $category budget! \n'
          'Spent: \$${currentAmount.toStringAsFixed(2)} / \$${budgetLimit.toStringAsFixed(2)}';
    } else if (percentageUsed >= 90) {
      message = '⚠️ You\'re close to exceeding your $category budget! \n'
          'Spent: \$${currentAmount.toStringAsFixed(2)} / \$${budgetLimit.toStringAsFixed(2)}';
    } else if (percentageUsed >= 75) {
      message =
          'ℹ️ You\'ve used ${percentageUsed.toStringAsFixed(0)}% of your $category budget';
    } else {
      return; // Don't show notification for less than 75%
    }

    await _flutterLocalNotificationsPlugin.show(
      1,
      'Budget Alert: $category',
      message,
      platformChannelSpecifics,
      payload: 'budget_alert_$category',
    );
  }

  // 3. Weekly Summary
  Future<void> showWeeklySummary({
    required double totalSpent,
    required double averageDaily,
    required String topCategory,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'weekly_summary',
      'Weekly Summary',
      channelDescription: 'Weekly expense summary notifications',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      styleInformation: BigTextStyleInformation(''),
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(sound: 'default', presentAlert: true),
    );

    final message = '📊 Weekly Summary:\n'
        'Total: \$${totalSpent.toStringAsFixed(2)}\n'
        'Daily Avg: \$${averageDaily.toStringAsFixed(2)}\n'
        'Top Category: $topCategory';

    await _flutterLocalNotificationsPlugin.show(
      2,
      'Your Weekly Expense Summary',
      message,
      platformChannelSpecifics,
      payload: 'weekly_summary',
    );
  }

  // 4. Bill Payment Reminder
  Future<void> scheduleBillReminder({
    required String billName,
    required DateTime dueDate,
    required double amount,
    int daysBefore = 1,
  }) async {
    final reminderDate = dueDate.subtract(Duration(days: daysBefore));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      '💳 Bill Reminder',
      '$billName of \$${amount.toStringAsFixed(2)} is due in $daysBefore day${daysBefore == 1 ? '' : 's'}',
      tz.TZDateTime.from(reminderDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'bill_reminders',
          'Bill Reminders',
          channelDescription: 'Reminders for upcoming bill payments',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(sound: 'default', presentAlert: true),
      ),
      // FIXED: Added required androidScheduleMode parameter
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'bill_reminder_$billName',
    );
  }

  // 5. Achievement Notification
  Future<void> showAchievement({
    required String title,
    required String description,
    required String icon,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      4,
      '🎉 Achievement Unlocked!',
      '$title: $description',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'achievements',
          'Achievements',
          channelDescription: 'Achievement notifications',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(sound: 'default', presentAlert: true),
      ),
      payload: 'achievement_$title',
    );
  }

  // 6. Custom Notification
  Future<void> showCustomNotification({
    required String title,
    required String body,
    required int id,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'custom_notifications',
      'Custom Notifications',
      channelDescription: 'Custom notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(sound: 'default', presentAlert: true),
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // 7. Cancel notifications
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // 8. Check permission status
  Future<bool> checkNotificationPermission() async {
    final result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return result ?? false;
  }

  // 9. Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  // 10. Clear notification badge (iOS)
  Future<void> clearBadge() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: false, sound: true);
  }
}
