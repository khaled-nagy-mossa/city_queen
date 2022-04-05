import 'package:flutter/cupertino.dart';

abstract class FontsStates {
  const FontsStates();
}

class InitState extends FontsStates {
  const InitState() : super();
}

class SelectedFontChangeStatus extends FontsStates {
  const SelectedFontChangeStatus({@required this.font})
      : assert(font != null, 'font value must not be null'),
        super();

  /// search value
  final String font;
}

class SearchValueChangeStatus extends FontsStates {
  const SearchValueChangeStatus({@required this.value})
      : assert(value != null, 'search value must not be null'),
        super();

  /// search value
  final String value;
}

class FontStyleChangedState extends FontsStates {
  const FontStyleChangedState({@required this.fontStyle})
      : assert(fontStyle != null, 'fontStyle must not be null'),
        super();

  /// new font style
  final String fontStyle;
}
