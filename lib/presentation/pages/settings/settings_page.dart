import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_event.dart';
import 'package:communitary_service_app/presentation/pages/settings/widgets/settings_card.dart';
import 'package:communitary_service_app/presentation/shared/widgets/vertical_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 70,
        right: 20,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SettingsCard(
                icon: Icons.edit,
                title: 'Editar mi Perfil',
                onPressed: () {},
              ),
              VerticalSpacer.v60().createSpace(),
              SettingsCard(
                icon: Icons.group,
                title: 'User Control',
                onPressed: () {},
              ),
              VerticalSpacer.v60().createSpace(),
              SettingsCard(
                icon: Icons.lock,
                title: 'Cambiar Contraseña',
                onPressed: () {},
              ),
              VerticalSpacer.v60().createSpace(),
              SettingsCard(
                icon: Icons.add,
                title: 'Agregar alergia',
                onPressed: () {},
              ),
              VerticalSpacer.v60().createSpace(),
              SettingsCard(
                icon: Icons.logout,
                title: 'Cerrar Sesión',
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
