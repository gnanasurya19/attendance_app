import 'package:flutter/material.dart';

class AppStyle {
  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
    } else {
      final currentScreen = screenSize.width < screenSize.height
          ? screenSize.width
          : screenSize.height;
      if (currentScreen > 1024) {
        scale = 1.25;
      } else if (currentScreen > 768) {
        scale = 1.19;
      } else if (currentScreen > 600) {
        scale = 1.17;
      } else if (currentScreen > 480) {
        scale = 1.1;
      } else if (currentScreen > 412) {
        scale = 1.03;
      } else if (currentScreen > 360) {
        scale = 1;
      } else {
        scale = 0.85;
      }
    }
  }
  late double scale;
  late final text = _AppText(scale);
  late final insets = _Insets(scale);
  late final icon = _IconSize(scale);
  late final radius = _Radius(scale);
}

class _AppText {
  _AppText(this.scale);
  late double scale;


  late TextStyle h = TextStyle(fontFamily: 'Roboto-Bold', fontSize: 55 * scale);

  late TextStyle h1 =
      TextStyle(fontFamily: 'Roboto-Bold', fontSize: 32 * scale);
  late TextStyle h2 =
      TextStyle(fontFamily: 'Roboto-Bold', fontSize: 26 * scale);
  late TextStyle h3 =
      TextStyle(fontFamily: 'Roboto-Bold', fontSize: 18 * scale);
  late TextStyle h4 =
      TextStyle(fontFamily: 'Roboto-Bold', fontSize: 16 * scale);
  late TextStyle h5 =
      TextStyle(fontFamily: 'Roboto-Bold', fontSize: 14 * scale);

  late TextStyle bodyTitleLg =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 24 * scale);
  late TextStyle bodyTitle =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 20 * scale);

  late TextStyle bodyContentLg =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 18 * scale);
  late TextStyle bodyContent =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 16 * scale);

  late TextStyle bodyContentSmall =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 14 * scale);
  late TextStyle bodyContentXSmall =
      TextStyle(fontFamily: 'Roboto-Regular', fontSize: 12 * scale);

  late TextStyle titleLarge =
      TextStyle(fontFamily: 'Roboto-Medium', fontSize: 20 * scale);
  late TextStyle titleMd =
      TextStyle(fontFamily: 'Roboto-Medium', fontSize: 16 * scale);
  late TextStyle title =
      TextStyle(fontFamily: 'Roboto-Medium', fontSize: 14 * scale);
  late TextStyle titleSmall =
      TextStyle(fontFamily: 'Roboto-Medium', fontSize: 12 * scale);

  late TextStyle lightText = const TextStyle(fontFamily: 'Roboto-Light');
}

class _Insets {
  _Insets(this.scale);
  late final double scale;
  late final xs = 5 * scale;
  late final sm = 8 * scale;
  late final md = 12 * scale;
  late final lg = 18 * scale;
  late final xl = 22 * scale;
  late final xxl = 30 * scale;
}

class _IconSize {
  _IconSize(this.scale);
  late final double scale;
  late final xxs = 15 * scale;
  late final xs = 24 * scale;
  late final sm = 28 * scale;
  late final md = 35 * scale;
  late final lg = 40 * scale;
  late final xl = 75 * scale;
}

class _Radius {
  _Radius(this.scale);
  late double scale;
  late final xs = 5 * scale;
  late final sm = 8 * scale;
  late final md = 12 * scale;
  late final lg = 16 * scale;
  late final xl = 20 * scale;
}
