extension IterableExtensions on Iterable<dynamic> {
  // Extension on Iterable
  List<Map<String, dynamic>> toListOfMaps() {
    List<Map<String, dynamic>> result = [];

    for (var item in this) {
      if (item is Map<String, dynamic>) {
        result.add(item);
      } else {
        // Handle non-map items (choose one):
        // Option 1: Skip them
        continue;
        // Option 2: Throw an exception
        // throw ArgumentError('Item is not a Map<String, dynamic>: $item');
        // Option 3: Add a default value
        // result.add({'unknown': item});
      }
    }
    return result;
  }
}
