import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/common/utils/background_service.dart';
import 'package:restaurant_app/common/utils/date_time_helper.dart';
import 'package:restaurant_app/data/local/preferences_helper.dart';

import 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final PreferencesHelper preferencesHelper;
  SettingCubit({
    required this.preferencesHelper,
  }) : super(const SettingState(isScheduled: false));

  Future<bool> scheduledNotification(bool value) async {
    emit(state.copyWith(isScheduled: value));

    if (state.isScheduled) {
      debugPrint('Scheduling Notification Activated');
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Notification Canceled');
      emit(state.copyWith(isScheduled: value));
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void getNotificationPreferences() async {
    final result = await preferencesHelper.isNotificationActive;
    emit(state.copyWith(isScheduled: result));
  }

  void enableNotification(bool value) {
    preferencesHelper.setNotification(value);
    getNotificationPreferences();
  }
}
