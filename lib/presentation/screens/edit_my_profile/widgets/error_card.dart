import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: AppColors.lightColor, fontWeight: FontWeight.bold);
    return GestureDetector(
      onTap: () => context.pop(),
      child: Center(
        child: Card(
          elevation: 2,
          color: AppColors.errorColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text(
              'Error al cargar el perfil. \n Intente mas tarde',
              textAlign: TextAlign.center,
              style: theme,
            ),
          ),
        ),
      ),
    );
  }
}
