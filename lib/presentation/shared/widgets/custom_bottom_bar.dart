import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/shared/blocs/bottom_navigation_cubit/bottom_navigation_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage =
        context.watch<BottomNavigationBarCubit>().state.currentPage;
    return BottomNavigationBar(
      elevation: 4,
      currentIndex: currentPage.index,
      fixedColor: AppColors.primaryContainer,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph_outlined),
          label: 'Reportes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2),
          label: 'Beneficiarios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
      onTap: (value) {
        context
            .read<BottomNavigationBarCubit>()
            .changePage(Pages.values[value]);
      },
    );
  }
}
