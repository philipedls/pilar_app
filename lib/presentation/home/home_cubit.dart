import 'package:bloc/bloc.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/usecases/get_immovable_usecase.dart';
import 'package:pilar_app/domain/usecases/search_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class HomeCubit extends Cubit<HomeState> {
  GetImmovableUseCase getImmovableUseCase;
  SearchImmovableUseCase searchImmovableUseCase;
  HomeCubit({
    required this.getImmovableUseCase,
    required this.searchImmovableUseCase,
  }) : super(HomeInitalState());

  Future<void> getAllImmovables() async {
    final result = await getImmovableUseCase();

    if (result.$1.faituleType != FaituleType.none) {
      emit(HomeErrorState());
    } else {
      emit(HomeSuccessState(result.$2));
    }
  }
}

abstract class HomeState {}

class HomeInitalState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ImmovableProperty> list;

  HomeSuccessState(this.list);
}

class HomeErrorState extends HomeState {}
