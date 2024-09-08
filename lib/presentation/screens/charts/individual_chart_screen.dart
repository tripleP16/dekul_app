import 'dart:async';

import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_state.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/charts/multibar_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/charts/multiline_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/report_description_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/time_controller_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_with_chips.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/autocomplete_with_chips_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChartScreen extends StatefulWidget {
  static const String routeName = 'individual_chart_screen';

  const IndividualChartScreen({super.key});

  @override
  State<IndividualChartScreen> createState() => _IndividualChartScreenState();
}

class _IndividualChartScreenState extends State<IndividualChartScreen> {
  final GlobalKey _chartKey = GlobalKey();

  bool isLoadingReport = false;

  Future<void> _generatePdf(
    String title,
    String description,
  ) async {
    await getIt<DownloadChartsService>().downloadChartsPdf(
      DownloadChartModel(
        chartKey: _chartKey,
        reportTitle: title,
        reportDescription: description,
        reportDate: DateTime.now().toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        final state = context.read<ReportsBloc>().state;
        context.read<ReportsBloc>().clearIndividualReports();
        context.read<ReportsBloc>().loadReport(state.query, null, null, null);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reporte Individual'),
        ),
        body: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    const _IndividualSearchBar(),
                    TimeControllerWidget(
                      onAnualPressed: state.isAnual
                          ? null
                          : () {
                              context.read<ReportsBloc>().loadIndividualReport(
                                  state.query.copyWith(isYearly: true),
                                  null,
                                  null,
                                  null);
                            },
                      onMonthlyPressed: state.isMonthly
                          ? null
                          : () {
                              context.read<ReportsBloc>().loadIndividualReport(
                                  state.query.copyWith(isYearly: false),
                                  null,
                                  null,
                                  null);
                            },
                    ),
                    if (state.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!state.isLoading && state.errorMessage != null)
                      _Chart(
                        chartKey: _chartKey,
                      ),
                    if (!state.isLoading && state.errorMessage == null)
                      Center(
                        child: Text(state.errorMessage!),
                      ),
                    const SizedBox(height: 40),
                    ReportDescription(
                      title: state.title,
                      text: state.text,
                    ),
                    const SizedBox(height: 40),
                    CustomElevatedButton.light(
                      onPressed: isLoadingReport
                          ? null
                          : () async {
                              setState(() {
                                isLoadingReport = true;
                              });
                              await _generatePdf(
                                state.title,
                                state.text,
                              );

                              setState(() {
                                isLoadingReport = false;
                              });
                            },
                      text: 'Descargar',
                      elevation: 2,
                      width: 50,
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _IndividualSearchBar extends StatefulWidget {
  const _IndividualSearchBar();

  @override
  State<_IndividualSearchBar> createState() => _IndividualSearchBarState();
}

class _IndividualSearchBarState extends State<_IndividualSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1 * 0), () {
      context.read<ReportsBloc>().onSearchBeneficiary(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportsBloc>().state;
    return Center(
      child: AutocompleteWithChips(
        viewModel: AutocompleteWithChipsViewModel(
          items: state.beneficiaryChips,
          selectedItems: state.selectedBeneficiariesChip,
          onSelected: (p0) {
            context.read<ReportsBloc>().selectBeneficiary(p0.value);
          },
          hintText: 'Buscar Beneficiario',
          onDelete: (p0) {
            context.read<ReportsBloc>().unselectBeneficiary(p0.value);
          },
          labelText: 'Buscar Beneficiario',
          icon: Icons.search,
          onChanged: _onSearchChanged,
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required GlobalKey<State<StatefulWidget>> chartKey,
  }) : _chartKey = chartKey;

  final GlobalKey<State<StatefulWidget>> _chartKey;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportsBloc>().state;
    return Center(
      child: RepaintBoundary(
        key: _chartKey,
        child: state.isAnual
            ? MultiLineChartWidget(
                individualReports: state.individualReports,
              )
            : MonthlyMultiBarChartWidget(
                individualReports: state.individualReports,
              ),
      ),
    );
  }
}
