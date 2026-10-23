import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const screen = 18.0;
  static const login = 28.0;
}

abstract final class AppRadii {
  static const field = 13.0;
  static const button = 14.0;
  static const card = 18.0;
  static const navCard = 19.0;
  static const logo = 24.0;
  static const logoCut = 8.0;

  static const logoBorder = BorderRadius.only(
    topLeft: Radius.circular(logo),
    topRight: Radius.circular(logo),
    bottomLeft: Radius.circular(logo),
    bottomRight: Radius.circular(logoCut),
  );
}

abstract final class AppShadows {
  static const large = BoxShadow(
    color: Color(0x2E08291B),
    blurRadius: 70,
    offset: Offset(0, 24),
  );

  static const medium = BoxShadow(
    color: Color(0x1A08291B),
    blurRadius: 28,
    offset: Offset(0, 10),
  );

  static const button = BoxShadow(
    color: Color(0x33133E2B),
    blurRadius: 24,
    offset: Offset(0, 10),
  );
}
