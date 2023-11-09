import 'dart:ui';

class ScreenUtil {
  static late ScreenUtil _instance;
  static const int defaultWidth = 414;
  static const int defaultHeight = 896;
  late num uiWidthPx;
  late num uiHeightPx;
  late bool allowFontScaling;

  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void init(
      {num width = defaultWidth,
        num height = defaultHeight,
        bool allowFontScaling = false}) {
    _instance = ScreenUtil._();
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;
    _pixelRatio = window.devicePixelRatio;
    _screenWidth = window.physicalSize.width;
    _screenHeight = window.physicalSize.height;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  static double get textScaleFactor => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidth => _screenWidth / _pixelRatio;

  static double get screenHeight => _screenHeight / _pixelRatio;

  static double get screenWidthPx => _screenWidth;

  static double get screenHeightPx => _screenHeight;

  static double get statusBarHeight => _statusBarHeight / _pixelRatio;

  static double get statusBarHeightPx => _statusBarHeight;

  static double get bottomBarHeight => _bottomBarHeight;

  double get scaleWidth => screenWidth / uiWidthPx;

  double get scaleHeight =>
      (_screenHeight - _statusBarHeight - _bottomBarHeight) / uiHeightPx;

  double get scaleText => scaleWidth;

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;


  double setSp(num fontSize, {bool allowFontScalingSelf = false}) =>
      allowFontScalingSelf
          ? (allowFontScalingSelf
          ? (fontSize * scaleText)
          : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScaling
          ? (fontSize * scaleText)
          : ((fontSize * scaleText) / _textScaleFactor));
}
