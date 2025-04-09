import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_event.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';
import 'package:pokedex/presentation/screens/home/widget/list_type_select.dart';

class ListSortSelection extends StatelessWidget {
  final ScrollController scrollController;
  const ListSortSelection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ButtonSelectionItem(
              colorBackGround: state.sortByType == SortByType.idAsc
                  ? const Color(0xFF333333)
                  : Colors.white,
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeGetListPokemon(
                          start: 0,
                          count: 20,
                          searchText: state.searchText,
                          type: state.types,
                          sortByType: SortByType.idAsc),
                    );
                Future.delayed(const Duration(milliseconds: 400), () {
                  // Code sẽ chạy sau 2 giây
                  Navigator.pop(context);
                });
              },
              text: "1-n",
              colorText: state.sortByType == SortByType.idAsc
                  ? Colors.white
                  : Colors.black,
            ),
            ButtonSelectionItem(
              colorBackGround: state.sortByType == SortByType.idDesc
                  ? const Color(0xFF333333)
                  : Colors.white,
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeGetListPokemon(
                          start: 0,
                          count: 20,
                          searchText: state.searchText,
                          type: state.types,
                          sortByType: SortByType.idDesc),
                    );
                Future.delayed(const Duration(milliseconds: 400), () {
                  // Code sẽ chạy sau 2 giây
                  Navigator.pop(context);
                });
              },
              text: "n-1",
              colorText: state.sortByType == SortByType.idDesc
                  ? Colors.white
                  : Colors.black,
            ),
            ButtonSelectionItem(
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeGetListPokemon(
                          start: 0,
                          count: 20,
                          searchText: state.searchText,
                          type: state.types,
                          sortByType: SortByType.nameAsc),
                    );
                Future.delayed(const Duration(milliseconds: 400), () {
                  // Code sẽ chạy sau 2 giây
                  Navigator.pop(context);
                });
              },
              colorBackGround: state.sortByType == SortByType.nameAsc
                  ? const Color(0xFF333333)
                  : Colors.white,
              text: "A-Z",
              colorText: state.sortByType == SortByType.nameAsc
                  ? Colors.white
                  : Colors.black,
            ),
            ButtonSelectionItem(
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeGetListPokemon(
                          start: 0,
                          count: 20,
                          searchText: state.searchText,
                          type: state.types,
                          sortByType: SortByType.nameDesc),
                    );
                Future.delayed(const Duration(milliseconds: 400), () {
                  // Code sẽ chạy sau 2 giây
                  Navigator.pop(context);
                });
              },
              text: "Z-A",
              colorBackGround: state.sortByType == SortByType.nameDesc
                  ? const Color(0xFF333333)
                  : Colors.white,
              colorText: state.sortByType == SortByType.nameDesc
                  ? Colors.white
                  : Colors.black,
            ),
          ],
        ),
      );
    });
  }
}

enum SortByType {
  idAsc('1-n'),
  idDesc('n-1'),
  nameAsc('A-Z'),
  nameDesc('Z-A');

  final String text;
  const SortByType(this.text);
}
