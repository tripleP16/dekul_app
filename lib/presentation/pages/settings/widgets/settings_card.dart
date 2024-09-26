import 'package:animate_do/animate_do.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const SettingsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Positioned(
                    left: 40,
                    top: 30,
                    child: Icon(
                      icon,
                      size: 40,
                      color: AppColors.alertColor,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
