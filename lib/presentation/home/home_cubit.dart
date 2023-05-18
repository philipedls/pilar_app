// ignore_for_file: unnecessary_getters_setters

import 'package:bloc/bloc.dart';
import 'package:pilar_app/data/models/immovable.dart';
import 'package:pilar_app/domain/usecases/decending_by_price_immovable_usecase.dart';
import 'package:pilar_app/domain/usecases/get_immovable_usecase.dart';
import 'package:pilar_app/domain/usecases/search_immovable_usecase.dart';
import 'package:pilar_app/infra/failures/base_failure.dart';
import 'package:pilar_app/presentation/utils/text.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetImmovableUseCase getImmovableUseCase;
  final SearchImmovableUseCase searchImmovableUseCase;
  final DecendingByPriceImmovableUseCase decendingByPriceImmovableUseCase;

  late List<ImmovableProperty> _loadedImmovables;

  List<ImmovableProperty> get loadedImmovables => _loadedImmovables;

  set loadedImmovables(List<ImmovableProperty> value) {
    _loadedImmovables = value;
  }

  HomeCubit({
    required this.getImmovableUseCase,
    required this.searchImmovableUseCase,
    required this.decendingByPriceImmovableUseCase,
  })  : _loadedImmovables = [],
        super(HomeInitalState());

  Future<void> getAllImmovables() async {
    emit(HomeLoadingState());
    final result = await getImmovableUseCase();

    _sameResponseState(result);
  }

  Future<void> getImmovablesDecendingByPrice(bool isDecending) async {
    emit(HomeLoadingState());

    final result = await decendingByPriceImmovableUseCase(isDecending);

    _sameResponseState(result);
  }

  Future<void> searchImmovables(String label) async {
    String pattern = label.toUpperCase().normalize();
    List<ImmovableProperty> resultList = loadedImmovables
        .where(
          (element) =>
              element.address!.toUpperCase().normalize().contains(pattern) || //
              element.city!.toUpperCase().normalize().contains(pattern) || //
              element.building!.toUpperCase().normalize().contains(pattern),
        )
        .toList();

    if (label.isEmpty) {
      emit(HomeSuccessState(loadedImmovables));
    } else {
      emit(HomeSearchState(resultList));
    }
  }

  void _sameResponseState((BaseFailure, List<ImmovableProperty>) value) {
    if (value.$1.faituleType != FaituleType.none) {
      emit(HomeErrorState());
    } else {
      loadedImmovables = value.$2;
      emit(HomeSuccessState(value.$2));
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

class HomeSearchState extends HomeState {
  final List<ImmovableProperty> list;

  HomeSearchState(this.list);
}

class HomeErrorState extends HomeState {}
