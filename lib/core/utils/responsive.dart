import 'package:flutter/material.dart';

double responsive(BuildContext context, double size) {
  double screenWidth = MediaQuery.of(context).size.width;
  return size * (screenWidth / 375).clamp(0.85, 1.2);
}
