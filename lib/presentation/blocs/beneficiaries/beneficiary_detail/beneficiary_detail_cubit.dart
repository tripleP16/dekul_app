import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiary_detail/beneficiary_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryDetailCubit extends Cubit<BeneficiaryDetailState> {
  final BeneficiariesRepository beneficiariesRepository;
  final String beneficiaryId;
  BeneficiaryDetailCubit(this.beneficiariesRepository, this.beneficiaryId)
      : super(BeneficiaryDetailState.initial()) {
    loadBeneficiaryDetails();
  }

  void loadBeneficiaryDetails() async {
    emit(state.copyWith(status: BeneficiaryDetailStatus.loading));

    try {
      final beneficiaryDetails =
          await beneficiariesRepository.getBeneficiary(beneficiaryId);
      emit(state.copyWith(
        status: BeneficiaryDetailStatus.loaded,
        model: () => beneficiaryDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryDetailStatus.error,
        errorMessage: () => e.toString(),
      ));
      return;
    }
  }
}
