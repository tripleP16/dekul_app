import 'package:communitary_service_app/presentation/blocs/allergies/allergies_cubit.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/allergies_state.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/forms/inputs/forms.dart';
import '../../../shared/widgets/view_models/autocomplete_with_chips_view_model.dart';

class MedicalHistoryFormBody extends StatefulWidget {
  const MedicalHistoryFormBody({super.key});

  @override
  State<MedicalHistoryFormBody> createState() => _MedicalHistoryFormBodyState();
}

class _MedicalHistoryFormBodyState extends State<MedicalHistoryFormBody> {
  @override
  void initState() {
    context.read<AllergiesCubit>().fetchAllergies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AllergiesCubit, AllergiesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final allergies = state.getCustomChipViewModels();
        return SizedBox(
            height: size.height * 0.8,
            child: Column(
              children: [
                CustomStepper(width: size.width),
                VerticalSpacer.v40().createSpace(),
                TextInputWidget(
                  labelText: 'Altura en cm',
                  onChanged: (p0) {},
                  keyboardType: TextInputType.number,
                ),
                VerticalSpacer.v36().createSpace(),
                TextInputWidget(
                  labelText: 'Peso en kg',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {},
                ),
                VerticalSpacer.v36().createSpace(),
                AutocompleteWithChips(
                  viewModel: AutocompleteWithChipsViewModel(
                    items: allergies,
                    onSelected: (p0) {},
                    hintText: 'Alergias',
                    onDelete: (p0) {},
                    labelText: 'Alergias',
                  ),
                ),
                VerticalSpacer.v36().createSpace(),
                const Spacer(),
                CustomElevatedButton.dark(
                  onPressed: () {},
                  text: 'Guardar',
                  elevation: 3,
                  width: 100,
                  height: 15,
                )
              ],
            ));
      },
    );
  }
}
