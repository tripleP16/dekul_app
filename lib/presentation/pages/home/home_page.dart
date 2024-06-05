import 'package:communitary_service_app/presentation/pages/beneficiaries/beneficiaries_page.dart';
import 'package:communitary_service_app/presentation/pages/reports/reports_page.dart';
import 'package:communitary_service_app/presentation/pages/settings/settings_page.dart';
import 'package:communitary_service_app/presentation/shared/blocs/bottom_navigation_cubit/bottom_navigation_bar_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home_page';
  const HomePage({super.key});

  static final List<Widget> _pages = [
    const ReportsPage(),
    const BeneficiariesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final page = context.watch<BottomNavigationBarCubit>().state.currentPage;
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(),
      body: SizedBox(child: _pages[page.index]),
    );
  }
}
