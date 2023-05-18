import 'package:flutter/material.dart';
import 'package:pilar_app/presentation/utils/currency.dart';

class ImmovableItem extends StatelessWidget {
  final String? address;
  final int? number;
  final String? type;
  final double? price;
  final int? immovableSettings;
  final String imageProvider;
  final int? bedrooms;
  final int? suites;
  final int? parkingSpots;

  const ImmovableItem({
    super.key,
    this.address,
    this.type,
    this.price,
    this.immovableSettings,
    required this.imageProvider,
    this.number,
    this.bedrooms,
    this.suites,
    this.parkingSpots,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(imageProvider),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '$address, $number',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '$price'.currencyFormat(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${bedrooms}QT ${suites}ST ${parkingSpots}VG',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
