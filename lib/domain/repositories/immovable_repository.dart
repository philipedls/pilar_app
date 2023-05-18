import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

abstract interface class ImmovableRepository {
  Future<(BaseFailure, List<ImmovableProperty>)> fetch();
  Future<(BaseFailure, List<ImmovableProperty>)> search(String pattern);
}
