import 'package:communitary_service_app/presentation/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';

class TimeControllerWidget extends StatelessWidget {
  const TimeControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomOutlinedButton(
          onPressed: () {},
          icon: Icons.auto_graph_outlined,
          text: 'Anual',
        ),
        CustomOutlinedButton(
          onPressed: () {},
          icon: Icons.calendar_month,
          text: 'Mensual',
        ),
      ],
    );
  }
}
