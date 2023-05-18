import 'package:pilar_app/data/datasources/immovable_datasource.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/repositories/immovable_repository.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class ImmovableRepositoryImpl implements ImmovableRepository {
  final ImmovableDatasource datasource;

  ImmovableRepositoryImpl({required this.datasource});
  @override
  Future<(BaseFailure, List<ImmovableProperty>)> fetch() => datasource.fetchAll();

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern) => datasource.search(pattern);
}
