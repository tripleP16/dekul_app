import 'package:communitary_service_app/presentation/screens/charts/widgets/report_description_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/time_controller_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_with_chips.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/autocomplete_with_chips_view_model.dart';
import 'package:flutter/material.dart';

class IndividualChartScreen extends StatefulWidget {
  static const String routeName = 'individual_chart_screen';

  const IndividualChartScreen({super.key});

  @override
  State<IndividualChartScreen> createState() => _IndividualChartScreenState();
}

class _IndividualChartScreenState extends State<IndividualChartScreen> {
  final GlobalKey _chartKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Individual'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Center(
                  child: AutocompleteWithChips(
                    viewModel: AutocompleteWithChipsViewModel(
                      items: [],
                      selectedItems: [],
                      onSelected: (p0) {},
                      hintText: 'Buscar Beneficiario',
                      onDelete: (p0) {},
                      labelText: 'Buscar Beneficiario',
                      icon: Icons.search,
                    ),
                  ),
                ),
                const TimeControllerWidget(),
                SizedBox(
                  height: size.height * 0.5,
                  child: Center(
                    child: RepaintBoundary(
                      key: _chartKey,
                      child: const SizedBox.shrink(),
                    ),
                  ),
                ),
                const ReportDescription(
                  title: 'Reporte Individual',
                  text: 'Reporte individual de la comunidad',
                ),
                const Spacer(
                  flex: 2,
                ),
                CustomElevatedButton.light(
                  onPressed: () {},
                  text: 'Descargar',
                  elevation: 2,
                  width: 50,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
