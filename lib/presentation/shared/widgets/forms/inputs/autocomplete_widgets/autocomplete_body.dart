import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_widgets/autocomplete_text_field.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_widgets/preview_chips_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/autocomplete_with_chips_view_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/custom_chip_view_model.dart';
import 'package:flutter/material.dart';

class AutoCompleteBody extends StatefulWidget {
  final AutocompleteWithChipsViewModel viewModel;

  const AutoCompleteBody({super.key, required this.viewModel});

  @override
  State<AutoCompleteBody> createState() => _AutoCompleteBodyState();
}

class _AutoCompleteBodyState extends State<AutoCompleteBody> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CustomChipViewModel>(
        optionsViewBuilder: (context, onSelected, options) {
      final optionsList = options.toList();

      return PreviewChipWidget(
          optionsList: optionsList,
          onTapped: () {
            _controller.text = '';
          });
    }, optionsBuilder: (TextEditingValue text) {
      return widget.viewModel.items
          .where((element) =>
              element.label.toLowerCase().contains(text.text.toLowerCase()))
          .toList();
    }, fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
      _controller = textEditingController;
      return AutoCompleteTextField(
          hintText: widget.viewModel.hintText,
          textEditingController: _controller,
          focusNode: focusNode);
    });
  }
}
