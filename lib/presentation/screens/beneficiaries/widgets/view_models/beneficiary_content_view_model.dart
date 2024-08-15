enum BeneficiaryViewModelState { text, ok, warning, bad }

class BeneficiaryContentViewModel {
  final String title;
  final BeneficiaryViewModelState state;
  final String value;

  const BeneficiaryContentViewModel({
    required this.title,
    required this.state,
    required this.value,
  });
}
