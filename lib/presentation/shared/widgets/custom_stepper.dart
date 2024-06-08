import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.02,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: width,
          height: size.height * 0.02,
          decoration: BoxDecoration(
            color: AppColors.alertColor,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ],
    );
  }
}
