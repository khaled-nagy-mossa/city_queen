import 'package:flutter/material.dart';

class BranchTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const BranchTab({
    @required this.title,
    @required this.onTap,
    @required this.selected,
  })  : assert(title != null),
        assert(selected != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.0,
        width: 140.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
        child: Text(
          title ?? '',
          style: TextStyle(
            color: selected ? Colors.black : Colors.black54,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
