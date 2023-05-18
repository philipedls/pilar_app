import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilar_app/presentation/home/home_cubit.dart';
import 'package:pilar_app/presentation/home/widgets/custom_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit cubit;

  String? dropdownvalue;

  var items = [
    'Mais caros',
    'Mais baratos',
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
          Spacer(flex: 2),
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
            padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Pesquisar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        cubit.searchImmovables(value);
                      },
                    ),
                  ),
                ),
                const Spacer(),
                DropdownButton(
                  underline: const SizedBox(
                    height: 0,
                    child: Divider(
                      color: Colors.black38,
                    ),
                  ),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
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
                  return Expanded(child: CustomGrid(list: cubit.loadedImmovables));

                case HomeSearchState:
                  final current = state as HomeSearchState;
                  return Expanded(child: CustomGrid(list: current.list));

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
