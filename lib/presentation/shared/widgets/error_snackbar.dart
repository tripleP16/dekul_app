import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  const ErrorSnackBar({Key? key, required content})
      : super(key: key, content: content, backgroundColor: Colors.red);
}
