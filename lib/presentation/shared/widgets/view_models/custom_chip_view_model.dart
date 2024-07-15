class CustomChipViewModel {
  final String label;
  final String value;

  CustomChipViewModel({
    required this.label,
    required this.value,
  });

  @override
  String toString() {
    return label;
  }
}
