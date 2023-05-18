import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/repositories/immovable_repository.dart';
import 'package:pilar_app/domain/usecases/get_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class GetImmovableUseCaseImpl implements GetImmovableUseCase {
  final ImmovableRepository repository;

  GetImmovableUseCaseImpl({required this.repository});

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> call() => repository.fetch();
}
