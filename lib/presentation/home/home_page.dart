import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilar_app/presentation/home/home_cubit.dart';
import 'package:pilar_app/presentation/home/widgets/immovable_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit cubit;

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    cubit.getAllImmovables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('Pilar'),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: cubit,
            builder: (context, state) {
              switch (cubit.state.runtimeType) {
                case HomeInitalState:
                case HomeLoadingState:
                  return const CircularProgressIndicator();

                case HomeSuccessState:
                  final current = state as HomeSuccessState;
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      itemCount: current.list.length,
                      itemBuilder: (context, index) => ImmovableItem(
                        address: current.list[index].address ?? '',
                        imageProvider: '',
                        immovableSettings: current.list[index].suites.toString(),
                        price: current.list[index].rentPrice.toString(),
                        type: current.list[index].developmentStage ?? '',
                      ),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 220,
                      ),
                    ),
                  );

                default:
                  return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
