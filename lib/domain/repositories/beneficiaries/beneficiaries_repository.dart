import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';

abstract class BeneficiariesRepository {
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel);
}
