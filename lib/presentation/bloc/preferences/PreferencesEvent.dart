import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/Preference.dart';


@immutable
abstract class PreferencesEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PreferenceLoadSuccess extends PreferencesEvent{}


class GetPreferenceEvent extends PreferencesEvent{
  final String name;

  GetPreferenceEvent(this.name);

  @override
  List<Object> get props => [name];
}

class WritePreferenceEvent extends PreferencesEvent{
  final Preference preference;

  WritePreferenceEvent(this.preference);

  @override
  List<Object> get props => [preference];
}

