import 'package:flutter/material.dart';

import '../model/country.dart';

class CountryItem extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const CountryItem({@required this.country, @required this.onTap})
      : assert(country != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Text(
          country.code??'',
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(country.name??''),
      ),
    );
  }
}
