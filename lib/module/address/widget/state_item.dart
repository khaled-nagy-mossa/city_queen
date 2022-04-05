import 'package:flutter/material.dart';

import '../model/state.dart';

class StateItem extends StatelessWidget {
  final StateLocation state;
  final VoidCallback onTap;

  const StateItem({@required this.state, @required this.onTap})
      : assert(state != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(state.name??''),
      ),
    );
  }
}
