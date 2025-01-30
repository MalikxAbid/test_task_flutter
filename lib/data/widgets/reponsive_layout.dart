import 'package:flutter/material.dart';

double getResponsiveWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * (width / 360);
}

double getResponsiveHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * (height / 800);
}
