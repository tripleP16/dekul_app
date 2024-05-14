//Create sized box with different heights 2, 4, 6, 8 , 16...

import 'package:flutter/material.dart';

class VerticalSpacer {
  final double height;

  VerticalSpacer(this.height);

  VerticalSpacer.v2() : height = 2;

  VerticalSpacer.v4() : height = 4;

  VerticalSpacer.v6() : height = 6;

  VerticalSpacer.v8() : height = 8;

  VerticalSpacer.v10() : height = 10;

  VerticalSpacer.v12() : height = 12;

  VerticalSpacer.v14() : height = 14;

  VerticalSpacer.v16() : height = 16;

  VerticalSpacer.v18() : height = 18;

  VerticalSpacer.v20() : height = 20;

  VerticalSpacer.v22() : height = 22;

  VerticalSpacer.v24() : height = 24;

  VerticalSpacer.v26() : height = 26;

  VerticalSpacer.v28() : height = 28;

  VerticalSpacer.v30() : height = 30;

  VerticalSpacer.v32() : height = 32;

  VerticalSpacer.v34() : height = 34;

  SizedBox createSpace() => SizedBox(height: height);
}
