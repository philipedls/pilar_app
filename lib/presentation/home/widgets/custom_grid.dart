import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/presentation/home/widgets/immovable_item.dart';

class CustomGrid extends StatelessWidget {
  final List<ImmovableProperty> list;
  const CustomGrid({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 15,
        mainAxisExtent: 220,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final maxRandom = list[index].images!.length;
        final radom = Random();

        return ImmovableItem(
          address: list[index].address,
          number: int.parse(list[index].number!),
          imageProvider: list[index].images![radom.nextInt(maxRandom)].url!,
          price: list[index].askingPrice?.toDouble(),
          type: list[index].propertyType,
          bedrooms: list[index].bedrooms?.toInt() ?? 0,
          suites: list[index].suites?.toInt() ?? 0,
          parkingSpots: list[index].parkingSpots?.toInt() ?? 0,
        );
      },
    );
  }
}
