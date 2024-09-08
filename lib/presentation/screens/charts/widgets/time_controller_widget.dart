import 'package:communitary_service_app/presentation/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';

class TimeControllerWidget extends StatelessWidget {
  final void Function()? onAnualPressed;
  final void Function()? onMonthlyPressed;
  const TimeControllerWidget(
      {super.key, this.onAnualPressed, this.onMonthlyPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomOutlinedButton(
          onPressed: onAnualPressed,
          icon: Icons.auto_graph_outlined,
          text: 'Anual',
        ),
        CustomOutlinedButton(
          onPressed: onMonthlyPressed,
          icon: Icons.calendar_month,
          text: 'Mensual',
        ),
      ],
    );
  }
}
