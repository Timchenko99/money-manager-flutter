
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../core/usecases/UseCase.dart';
import '../../domain/usecases/GetPreferences.dart';
import '../../domain/usecases/WritePreferences.dart';
import '../../domain/entities/Preference.dart';

part './PreferenceState.dart';


class PreferenceCubit extends Cubit<PreferenceState>{
  final GetPreferences getPreferencesUseCase;
  final WritePreferences writePreferencesUseCase;

  PreferenceCubit({this.getPreferencesUseCase, this.writePreferencesUseCase}) : super(PreferenceInitialState());

  getPreferences() async{
    emit(PreferenceLoadingState());
    final preference = await getPreferencesUseCase(NoParams());
    preference.fold(
            (failure) => this.emit(PreferenceErrorState()) ,
            (preference) => this.emit(PreferenceLoadedState(preference))
    );
  }

  writePreferences(Preference preference) async{
    await writePreferencesUseCase(WritePreferencesParams(preference));
    this.getPreferences();
  }
}