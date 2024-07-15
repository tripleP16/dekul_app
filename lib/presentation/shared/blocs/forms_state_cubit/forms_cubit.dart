import 'package:flutter_bloc/flutter_bloc.dart';

part 'forms_state.dart';

class FormCubit extends Cubit<FormsState> {
  FormCubit() : super(FormsInitialState());

  Future<void> formSubmit<T>(Future<void> formSubmit) async {
    emit(FormsSubmittingState());
    try {
      await formSubmit;
      emit(FormsSubmitSuccessState());
    } catch (e) {
      emit(FormsSubmitErrorState(e.toString()));
    }
  }
}
