import 'dart:convert';
import 'dart:io';

import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

abstract interface class ImmovableDatasource {
  Future<(BaseFailure, List<ImmovableProperty>)> fetchAll();
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern);
}

class ImmovableDatasourceImpl implements ImmovableDatasource {
  final String _filePath = 'assets/properties.json';
  @override
  Future<(BaseFailure, List<ImmovableProperty>)> fetchAll() async {
    File mockFile = File(_filePath);
    String mock = await mockFile.readAsString();

    return (BaseFailure.none(), ImmovableProperty.fromList(json.decode(mock)));
  }

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern) async {
    File mockFile = File(_filePath);
    String mock = await mockFile.readAsString();

    List<ImmovableProperty> immovablePropertyList = ImmovableProperty.fromList(json.decode(mock));
    List<ImmovableProperty> resultList = immovablePropertyList
        .where(
          (element) => element.address == pattern || element.city == pattern || element.building == pattern,
        )
        .toList();

    return (BaseFailure.none(), resultList);
  }
}
