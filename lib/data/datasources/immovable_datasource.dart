import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

abstract interface class ImmovableDatasource {
  Future<(BaseFailure, List<ImmovableProperty>)> fetchAll();
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern);
  Future<(BaseFailure, List<ImmovableProperty>)> orderByPrice(bool flag);
}

class ImmovableDatasourceImpl implements ImmovableDatasource {
  final String _path = 'assets/properties.json';

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> fetchAll() {
    return Future.delayed(
      const Duration(seconds: 2),
      () async {
        final String mock = await rootBundle.loadString(_path);
        final list = ImmovableProperty.fromList(jsonDecode(mock.replaceAll('\n', '')));

        return (BaseFailure.none(), list);
      },
    );
  }

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern) async {
    final String mock = await rootBundle.loadString(_path);
    final list = ImmovableProperty.fromList(jsonDecode(mock.replaceAll('\n', '')));

    List<ImmovableProperty> immovablePropertyList = ImmovableProperty.fromList(list);
    List<ImmovableProperty> resultList = immovablePropertyList
        .where(
          (element) => element.address == pattern || element.city == pattern || element.building == pattern,
        )
        .toList();

    return (BaseFailure.none(), resultList);
  }

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> orderByPrice(bool flag) async {
    final String mock = await rootBundle.loadString(_path);
    final list = ImmovableProperty.fromList(jsonDecode(mock.replaceAll('\n', '')));
    list.sort(
      (valueA, valueB) => (valueA.askingPrice!).compareTo(valueB.askingPrice!),
    );

    return (BaseFailure.none(), flag ? list : list.reversed.toList());
  }
}
