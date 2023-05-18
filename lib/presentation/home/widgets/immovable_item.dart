import 'package:flutter/material.dart';

class ImmovableItem extends StatelessWidget {
  final String address;
  final String type;
  final String price;
  final String immovableSettings;
  final String imageProvider;

  const ImmovableItem({
    super.key,
    required this.address,
    required this.type,
    required this.price,
    required this.immovableSettings,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(address),
            Text(price),
            Text(immovableSettings),
          ],
        ),
      ),
    );
  }
}
