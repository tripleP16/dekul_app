import 'package:flutter/material.dart';

class MainLogoWidget extends StatelessWidget {
  final Size size;
  const MainLogoWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/logo/main_logo.jpg',
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
