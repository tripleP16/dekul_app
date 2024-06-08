import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBeneficiaryBloc
    extends Bloc<RegisterBeneficiaryEvent, RegisterBeneficiaryState> {
  RegisterBeneficiaryBloc() : super(RegisterBeneficiaryState()) {
    on<RegisterBeneficiaryEvent>((event, emit) {});
  }
}
