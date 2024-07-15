part of 'forms_cubit.dart';

abstract class FormsState {}

class FormsInitialState extends FormsState {}

class FormsSubmittingState extends FormsState {}

class FormsSubmitSuccessState extends FormsState {}

class FormsSubmitErrorState extends FormsState {
  final String errorMessage;

  FormsSubmitErrorState(this.errorMessage);
}
