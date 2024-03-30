class AppDimensions {
  const AppDimensions._();

  /// The max phone width which is used responsive UI.
  static const int maxPhoneWidth = 640;

  /// The number of max horizontal cell in grid view when it is portrait mode.
  static const int weatherDetailGridViewPortraitCellSize = 2;

  /// The number of max horizontal cell in grid view when it is landscape mode.
  static const int weatherDetailGridViewLandscapeCellSize = 4;

  // Card Size
  static double get cardIconSize => 35.0;

  // ListTile Size
  static double get listTileLeadingIconSize => 30.0;
  static double get listTileTrailingIconSize => 20.0;

  // Button Border Radius
  static double get buttonBorderRadius => 10.0;

  // Widget
  static double get widgetElevation => 0.0;
  static double get widgetHeight => 50.0;
}
