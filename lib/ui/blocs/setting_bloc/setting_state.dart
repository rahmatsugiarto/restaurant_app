class SettingState {
  final bool isScheduled;

  const SettingState({required this.isScheduled});

  SettingState copyWith({bool? isScheduled}) {
    return SettingState(isScheduled: isScheduled ?? this.isScheduled);
  }
}
