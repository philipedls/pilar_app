import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

abstract interface class DecendingByPriceImmovableUseCase {
  Future<(BaseFailure, List<ImmovableProperty>)> call(bool flag);
}
