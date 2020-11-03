
part of './PreferenceCubit.dart';

@immutable
abstract class PreferenceState {}

class PreferenceInitialState extends PreferenceState {}

class PreferenceLoadingState extends PreferenceState{}

class PreferenceLoadedState extends PreferenceState{
  final Preference preference;

  PreferenceLoadedState(this.preference);
}

class PreferenceErrorState extends PreferenceState{}
