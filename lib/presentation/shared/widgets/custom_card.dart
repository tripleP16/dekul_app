import 'package:animate_do/animate_do.dart';
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
  final Color color;
  const CustomCard({
    super.key,
    required this.size,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.icon,
    this.buttonText,
    this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: FadeInLeft(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 26,
              ),
            ],
          ),
          child: Stack(
            children: [
              if (icon != null)
                _IconWidget(
                  icon: icon,
                  color: color,
                ),
              _TextContainer(title: title, subtitle: subtitle),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextContainer extends StatelessWidget {
  const _TextContainer({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            if (subtitle != null) ...[
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.67),
                    ),
              ),
              VerticalSpacer.v24().createSpace(),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({
    required this.icon,
    required this.color,
  });

  final String? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              icon!,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: color.withOpacity(0.5),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
