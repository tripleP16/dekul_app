import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/snackbars_service.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWrapper extends StatefulWidget {
  final Widget child;
  final String successContent;

  const FormWrapper(
      {super.key, required this.child, required this.successContent});

  @override
  State<FormWrapper> createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  bool _isLoading = false;

  void _toggleIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormCubit, FormsState>(
      listener: (context, state) {
        if (state is FormsSubmitSuccessState) {
          getIt<SnackbarsService>()
              .showSuccessSnackbar(widget.successContent, context);
        }
        if (state is FormsSubmitErrorState) {
          getIt<SnackbarsService>()
              .showErrorSnackbar(state.errorMessage, context);
        }
        if (state is FormsSubmittingState) {
          _toggleIsLoading();
          return;
        }
        _toggleIsLoading();
      },
      child: _isLoading
          ? const CircularProgressIndicator(
              strokeWidth: 2,
            )
          : widget.child,
    );
  }
}
