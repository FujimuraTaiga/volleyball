enum WidgetSize{
  signInButton,
  userImageInMyPage,
}

extension WidgetSizeExtension on WidgetSize{

  static final widgetHeight = {
    WidgetSize.signInButton       : 35.0,
    WidgetSize.userImageInMyPage  : 120.0,
  };

  static final widgetWidth = {
    WidgetSize.signInButton       : 250.0,
    WidgetSize.userImageInMyPage  : 120.0,
  };

  static final fontSize = {
    WidgetSize.signInButton : 18.0,
  };

  double get height => widgetHeight[this]!;
  double get width => widgetWidth[this]!;
  double get font => fontSize[this]!;
}