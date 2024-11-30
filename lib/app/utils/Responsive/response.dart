import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class Responsive extends StatelessWidget {

  Responsive(
      {required this.child,
        this.originalScreenHeight = 759,
        this.originalScreenWidth = 392});

  final double originalScreenHeight;

  final double originalScreenWidth;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ///`OrientationBuilder` is used to get the orientation mode of
        ///the device in which the app is working on.
        return OrientationBuilder(
          builder: (context, orientation) {
            ResponseUI._init(constraints, orientation, constraints.maxHeight / 1.25 ,
                constraints.maxWidth / 2.3, context);
            return child;
          },
        );
      },
    );
  }
}

///
///[ResponseUI] is the main brain of the package.
///
///We are using it to calculate the geometric value of our widgets
///in which we define for example a specific [width] or [height] in pixels
///and in that case we want the specified property to be constant whatever the
///device screen size would be.
///
///For example:
///if you want to specific a constant [height] and [width] to your container
///lets say it will be 100 pixels in height and 100 pixels in width, you will
///type the [height] property = 100 and the [width] property = 100, So in that
///case you want to maintain these [height] and [width] property relative to
///the device screen size you originally designed your app on.
///
/// in that case the class/package will do the work to change these relative
/// [height] and [width] to maintain the same display occupation size.
///
///
class ResponseUI {
  static ResponseUI? _instance;
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static bool _isPortrait = true;
  static bool _isMobilePortrait = false;
  static double fixedHeightFactor = 0;
  static double _fixedWidthFactor = 0;
  static double _originalWidth = 0;
  static double _originalHeight = 0;
  static BuildContext? _context;
  MediaQueryData? _mediaQuery;

  static ResponseUI? get instance {
    if (_instance == null) {
      _instance = ResponseUI();
    }
    return _instance;
  }

  static void _init(BoxConstraints constraints, Orientation orientation,
      double originalHeight, double originalWidth, BuildContext context) {
    _originalHeight = originalHeight;
    _originalWidth = originalWidth;

    // if (_instance == null) {
    //   _instance = ResponseUI._();
    // }
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      _isPortrait = true;
      if (_screenWidth! < 450) {
        _isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      _isPortrait = false;
      _isMobilePortrait = false;
    }
    _blockHeight = _screenHeight! / 100;
    _blockWidth = _screenWidth! / 100;
    fixedHeightFactor = originalHeight / 100;
    _fixedWidthFactor = originalWidth / 100;

    //! Testing/Beta version
    _context = context;
  }

  ///`isDevicePortrait` is helpful if you want to know whether the device orientation is
  ///in Portrait or in Landscape, it can ably to any device (Tablet or Mobil Phone).
  bool get isDevicePortrait => _isPortrait;

  ///`inMobilePortrait` is helpful if you want to know whether the device you are
  ///working on a Mobile Portrait or a Tablet Portrait mode and you can take action
  ///according to these information ot layout your UI.
  bool get inMobilePortrait => _isMobilePortrait;

  ///`screenWidth` returns the current device screen width.
  ///Note: You can use it instead of `MediaQuery.of(context).size.width`
  double get screenWidth => _screenWidth!;

  ///`screenHeight` returns the current device screen height.
  ///Note: You can use it instead of `MediaQuery.of(context).size.height`
  double get   screenHeight => _screenHeight!;
  double get   marginTopBottom => _screenHeight! / 4;
  double get   marginRightLeft=> _screenWidth! / 2;



  double setWidth(double width) {
    double _widthCorrectionFactor = _fixedWidthFactor;
    //if the current device is Mobile
    if (_fixedWidthFactor < _blockWidth * 0.6) {
      _widthCorrectionFactor *= 1.48;
    }
    //if the original device is Tablet
    if (_originalWidth > _screenWidth!) {
      _widthCorrectionFactor /= 1.75;
    }
    return ((width / _widthCorrectionFactor) * _blockWidth);
  }



  ///`height` is the widget height which you want it to be the same across any screen size.
  double setHeight(double height) {
    double _heightCorrectionFactor = fixedHeightFactor;
    //if the original device is Tablet
    if (_originalWidth > _screenWidth!) {
      _heightCorrectionFactor /= 1.25;
    }
    return ((height / _heightCorrectionFactor) * _blockHeight);
  }



  double setFontSize(double fontSize) {
    double _heightCorrectionFactor = fixedHeightFactor;
    //if the original device is Tablet
    if (_originalWidth > _screenWidth!) {
      _heightCorrectionFactor /= 1.2;
    }
    return ((fontSize / _heightCorrectionFactor) * _blockHeight / 01.1); //in default no /
  }

  final String errorMessage = '''couldn't find context
Context can't equal 'null'
if you want to use any `MediaQuery` related functions, you should set the `Response` widget as a child (home) to the `MaterialApp` widget''';


  double get screenPixelRatio {
    try {
      _mediaQuery = MediaQuery.of(_context!);
      return _mediaQuery!.devicePixelRatio;
    } catch (e) {
      throw errorMessage;
    }
  }


  double get textScaleFactor {
    try {
      _mediaQuery = MediaQuery.of(_context!);
      return _mediaQuery!.textScaleFactor;

    } catch (e) {
      throw errorMessage;
    }
  }
  bool isOrientationPortrait(context){
    if(MediaQuery.of(context).orientation != Orientation.portrait){
      return true;
    }else{
      return false;

    }

  }


  bool isKeyBoardOpen(context){
    if(MediaQuery.of(context).viewInsets.bottom == 0){
      return false;
    }else{
      return true;

    }

  }

  /// The padding offset from the bottom.
  double get bottomPadding {
    try {
      _mediaQuery = MediaQuery.of(_context!);
      return _mediaQuery!.padding.bottom;
    } catch (e) {
      throw errorMessage;
    }
  }

  double getWidth(context) {
    return (MediaQuery.of(context).size.width);
  }

  double getHeight(context) {
    return (MediaQuery.of(context).size.height);
  }

  /// The padding offset from the top.
  double get topPadding {
    try {
      _mediaQuery = MediaQuery.of(_context!);
      return _mediaQuery!.padding.top;
    } catch (e) {
      throw errorMessage;
    }
  }
}