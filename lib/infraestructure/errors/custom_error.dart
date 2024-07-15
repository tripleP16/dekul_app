class CustomError implements Exception {
  final String message;

  CustomError({required this.message});

  @override
  String toString() {
    return message;
  }
}
