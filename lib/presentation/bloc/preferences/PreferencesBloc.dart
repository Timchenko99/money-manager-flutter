import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/UseCase.dart';
import '../../../domain/entities/Preference.dart';
import '../../../domain/usecases/GetPreferences.dart';
import '../../../domain/usecases/WritePreferences.dart';
import './preferences_bloc.dart';


class PreferenceBloc extends Bloc<PreferencesEvent, PreferencesState>{
  final GetPreferences getPreferences;
  final WritePreferences writePreferences;

  PreferenceBloc({this.getPreferences, this.writePreferences}):super(EmptyState());

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if(event is GetPreferenceEvent){
      final preferences = await getPreferences(NoParams());
      yield* _eitherPreferencesOrErrorState(preferences);
    }else if(event is WritePreferenceEvent){
      final preference = await writePreferences(WritePreferencesParams(event.preference));
      yield* _eitherWriteOrErrorState(preference);
    }
  }

  Stream<PreferencesState> _eitherWriteOrErrorState(Either<Failure, bool> failureOrTransaction) async*{
    yield failureOrTransaction.fold(
          (failure) => ErrorState(message: _mapFailureToMessage(failure)),
          (preferences) => WritePreferenceState(),
    );
  }

  Stream<PreferencesState> _eitherPreferencesOrErrorState(Either<Failure, Preference> failureOrTransaction) async*{
    yield failureOrTransaction.fold(
          (failure) => ErrorState(message: _mapFailureToMessage(failure)),
          (preferences) => GetPreferenceState(),
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return "Server failure";
      case LocalDataFailure:
        return "Local Data failure";
      default:
        return "Unexpected Error";
    }
  }
}