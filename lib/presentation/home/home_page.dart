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

  String? dropdownvalue;

  var items = [
    'Mais Caros',
    'Menos Caros',
  ];

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    cubit.getAllImmovables();
    super.initState();
  }

  void valueUpdate(String? newValue) {
    setState(() {
      dropdownvalue = newValue!;
    });
    bool flag = newValue == items[0];
    cubit.getImmovablesDecendingByPrice(!flag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: false,
        actions: const [
          Spacer(),
          Text('Pilar', style: TextStyle(color: Colors.white, fontSize: 18)),
          Spacer(
            flex: 2,
          ),
          Icon(Icons.home, size: 30, color: Colors.white),
          Spacer(),
          Icon(Icons.handshake, size: 30, color: Colors.white),
          Spacer(),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Spacer(),
          Icon(Icons.exit_to_app, size: 30, color: Colors.white),
          Spacer(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: valueUpdate,
                ),
              ],
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: cubit,
            builder: (context, state) {
              switch (cubit.state.runtimeType) {
                case HomeInitalState:
                case HomeLoadingState:
                  return const Expanded(
                    child: Align(
                      child: CircularProgressIndicator(),
                    ),
                  );

                case HomeSuccessState:
                  final current = state as HomeSuccessState;

                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 220,
                      ),
                      itemCount: current.list.length,
                      itemBuilder: (context, index) => ImmovableItem(
                        address: current.list[index].address,
                        number: int.parse(current.list[index].number!),
                        imageProvider: current.list[index].images![0].url!,
                        price: current.list[index].askingPrice?.toDouble(),
                        type: current.list[index].propertyType,
                        bedrooms: current.list[index].bedrooms?.toInt() ?? 0,
                        suites: current.list[index].suites?.toInt() ?? 0,
                        parkingSpots: current.list[index].parkingSpots?.toInt() ?? 0,
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
