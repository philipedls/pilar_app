import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/repositories/immovable_repository.dart';
import 'package:pilar_app/domain/usecases/decending_by_price_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class DecendingByPriceImmovableUseCaseImpl implements DecendingByPriceImmovableUseCase {
  final ImmovableRepository repository;

  DecendingByPriceImmovableUseCaseImpl({required this.repository});

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> call(bool flag) => repository.orderByPrice(flag);
}
