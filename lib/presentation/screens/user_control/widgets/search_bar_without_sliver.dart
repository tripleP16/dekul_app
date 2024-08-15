import 'dart:async';

import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:flutter/material.dart';

class SearchBarWithoutSliver extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;
  final Duration debounceDuration;

  const SearchBarWithoutSliver({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  State<SearchBarWithoutSliver> createState() => _SearchBarWithoutSliverState();
}

class _SearchBarWithoutSliverState extends State<SearchBarWithoutSliver> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      borderRadius: 40,
      labelText: widget.labelText,
      onChanged: _onSearchChanged,
      suffixIcon: const Icon(Icons.search),
    );
  }
}
