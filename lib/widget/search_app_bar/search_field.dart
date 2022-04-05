import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Search Widget In AppBar.actions
class AppBarSearchField extends StatelessWidget {
  /// Initializes [onTap, key] for subclasses.
  const AppBarSearchField({@required this.onSearch, this.onChanged, Key key})
      : super(key: key);

  ///method called when User need to search
  final void Function(String value) onSearch;

  ///method called when words changed
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onSearch,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'write to search ...',
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.properties.addAll([
      DiagnosticsProperty<void Function(String value)>('on_search', onSearch),
      DiagnosticsProperty<void Function(String value)>('on_changed', onChanged),
    ]);
  }
}
