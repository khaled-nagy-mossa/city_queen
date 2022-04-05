import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/address.dart';

class AddressItem extends StatelessWidget {
  final Address address;
  final VoidCallback onTab;

  const AddressItem({@required this.address, @required this.onTab})
      : assert(address != null),
        assert(onTab != null);

  @override
  Widget build(BuildContext context) {
    try {
      return GestureDetector(
        onTap: onTab,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                minVerticalPadding: 0.0,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${address?.country?.name ?? ''} (${address?.state?.name})',
                ),
                subtitle: Text(
                  '${address?.lat},${address?.lng}',
                ),
              ),
              Text(
                address?.address ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      log('Exception in AddressItem : $e');
      return const SizedBox();
    }
  }
}
