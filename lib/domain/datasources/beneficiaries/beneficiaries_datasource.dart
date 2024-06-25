import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';

abstract class BeneficiariesDatasource {
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel);
}
