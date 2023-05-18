import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilar_app/data/datasources/immovable_datasource.dart';
import 'package:pilar_app/data/repositories/immovable_repository_impl.dart';
import 'package:pilar_app/data/usecases/get_immovable_usecase_impl.dart';
import 'package:pilar_app/data/usecases/search_immovable_usecase_impl.dart';
import 'package:pilar_app/domain/repositories/immovable_repository.dart';
import 'package:pilar_app/presentation/home/home_cubit.dart';
import 'package:pilar_app/presentation/home/home_page.dart';

class PilarApp extends StatelessWidget {
  PilarApp({super.key});

  final List<RepositoryProvider> _repositories = [
    RepositoryProvider<ImmovableRepository>(
      create: (_) => ImmovableRepositoryImpl(
        datasource: ImmovableDatasourceImpl(),
      ),
    )
  ];

  final List<BlocProvider> _providers = [
    BlocProvider<HomeCubit>(
      create: (BuildContext context) => HomeCubit(
        getImmovableUseCase: GetImmovableUseCaseImpl(
          repository: context.read<ImmovableRepository>(),
        ),
        searchImmovableUseCase: SearchImmovableUseCaseImpl(
          repository: context.read<ImmovableRepository>(),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _repositories,
      child: MultiBlocProvider(
        providers: _providers,
        child: MaterialApp(
          title: 'Pilar App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
