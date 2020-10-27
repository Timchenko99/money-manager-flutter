import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class PreferencesState extends Equatable{
  @override
  List<Object> get props => [];
}

class EmptyState extends PreferencesState{}

class GetPreferenceState extends PreferencesState{}

class WritePreferenceState extends PreferencesState{}

class ErrorState extends PreferencesState{
  final String message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
