class AutocompleteWithChipsViewModel<T> {
  final List<T> items;
  final Function(T) onSelected;
  final Function(T) onDelete;
  final String labelText;
  final String hintText;

  AutocompleteWithChipsViewModel({
    required this.items,
    required this.onSelected,
    required this.onDelete,
    required this.labelText,
    required this.hintText,
  });
}
