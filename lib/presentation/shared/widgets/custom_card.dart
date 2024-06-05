import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Size size;
  final String title;
  final String? subtitle;
  final void Function()? onPressed;
  final String? text;
  final String? buttonText;
  final String? icon;
  const CustomCard({
    super.key,
    required this.size,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.icon,
    this.buttonText,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.onPrimary,
      elevation: 2,
      child: SizedBox(
        height: size.height * 0.37,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (subtitle != null) ...[
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              VerticalSpacer.v24().createSpace(),
            ],
            if (text != null) ...[
              Text(
                text!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              VerticalSpacer.v12().createSpace(),
            ],
            if (icon != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  icon!,
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                ),
              ),
            ],
            const Spacer(),
            if (buttonText != null && onPressed != null) ...[
              Align(
                alignment: Alignment.bottomRight,
                child: CustomElevatedButton.dark(
                  onPressed: onPressed,
                  text: buttonText!,
                  elevation: 2,
                  width: 10,
                  height: 10,
                ),
              ),
            ]
          ]),
        ),
      ),
    );
  }
}
