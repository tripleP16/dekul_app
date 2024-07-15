import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FogotPasswordBody extends StatelessWidget {
  final ForgotPasswordBodyViewModel viewModel;

  const FogotPasswordBody({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        TextInputWidget(
          labelText: viewModel.labelText,
          onChanged: viewModel.onChanged,
          errorText: viewModel.errorText,
          initialValue: viewModel.initialValue,
        ),
        const Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: viewModel.textWidget,
        ),
        const Spacer(
          flex: 1,
        ),
        CustomElevatedButton.light(
          onPressed: viewModel.onPressed,
          text: viewModel.buttonLabel,
          elevation: 3,
          width: 80,
          height: 20,
        ),
      ],
    );
  }
}
