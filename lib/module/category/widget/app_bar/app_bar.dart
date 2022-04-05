import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'search_field.dart';

///categories screen Bar in all app screens
class CategoriesViewAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  /// Initializes [onSearch, key] for subclasses.
  const CategoriesViewAppBar({
    @required this.onSearch,
    @required this.onSearchClosed,
    @required this.title,
    this.onChanged,
    Key key,
  }) : super(key: key);

  ///method called when User need to search
  final void Function(String value) onSearch;

  ///method called when words changed
  final void Function(String value) onChanged;

  ///called when user close search
  final VoidCallback onSearchClosed;

  ///
  final String title;

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.properties.addAll([
      DiagnosticsProperty<void Function(String value)>('on_search', onSearch),
      DiagnosticsProperty<void Function(String value)>('on_changed', onChanged),
      DiagnosticsProperty<VoidCallback>('on_search_closed', onSearchClosed),
    ]);
  }

  @override
  _CategoriesViewAppBarState createState() => _CategoriesViewAppBarState();
}

class _CategoriesViewAppBarState extends State<CategoriesViewAppBar> {
  bool _searchMode = false;

  void _changeSearchMode() {
    setState(() {
      _searchMode = !_searchMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _searchMode
          ? AppBarSearchField(
              onSearch: widget.onSearch,
              onChanged: widget.onChanged,
            )
          : Text(
              widget.title ?? '',
              style: TextStyle(color: Colors.grey[800]),
            ),
      actions: [
        if (_searchMode)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (widget.onSearchClosed != null) {
                widget.onSearchClosed();
              }
              _changeSearchMode();
            },
          )
        else
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _changeSearchMode,
          ),
      ],
    );
  }
}
