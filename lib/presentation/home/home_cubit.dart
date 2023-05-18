import 'package:bloc/bloc.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/usecases/decending_by_price_immovable_usecase.dart';
import 'package:pilar_app/domain/usecases/get_immovable_usecase.dart';
import 'package:pilar_app/domain/usecases/search_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetImmovableUseCase getImmovableUseCase;
  final SearchImmovableUseCase searchImmovableUseCase;
  final DecendingByPriceImmovableUseCase decendingByPriceImmovableUseCase;

  HomeCubit({
    required this.getImmovableUseCase,
    required this.searchImmovableUseCase,
    required this.decendingByPriceImmovableUseCase,
  }) : super(HomeInitalState());

  Future<void> getAllImmovables() async {
    emit(HomeLoadingState());
    final result = await getImmovableUseCase();

    if (result.$1.faituleType != FaituleType.none) {
      emit(HomeErrorState());
    } else {
      emit(HomeSuccessState(result.$2));
    }
  }

  Future<void> getImmovablesDecendingByPrice(bool isDecending) async {
    emit(HomeLoadingState());

    final result = await decendingByPriceImmovableUseCase(isDecending);

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
