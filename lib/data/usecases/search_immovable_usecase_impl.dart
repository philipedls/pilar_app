import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/repositories/immovable_repository.dart';
import 'package:pilar_app/domain/usecases/search_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class SearchImmovableUseCaseImpl implements SearchImmovableUseCase {
  final ImmovableRepository repository;

  SearchImmovableUseCaseImpl({required this.repository});

  @override
  Future<(BaseFailure, List<ImmovableProperty>)> call(String pattern) => repository.search(pattern);
}
