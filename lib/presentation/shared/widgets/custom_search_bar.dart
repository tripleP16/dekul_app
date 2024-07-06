import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CustomSearchBar extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;
  final Duration debounceDuration;

  const CustomSearchBar({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
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
    return SliverAppBar(
      floating: true,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextInputWidget(
                borderRadius: 40,
                labelText: widget.labelText,
                onChanged: _onSearchChanged,
                suffixIcon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
