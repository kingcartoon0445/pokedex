import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_event.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';

class ItemStyleSelect extends StatelessWidget {
  final ScrollController scrollController;

  const ItemStyleSelect({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    List<String> duy = [];
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.listGenerationModel == null) {
        return const CircularProgressIndicator();
      }

      return Column(
        children: [
          ButtonSelectionItem(
            onTap: () {
              context.read<HomeBloc>().add(HomeGetListPokemon(
                  start: 0,
                  count: 20,
                  type: const [],
                  sortByType: state.sortByType,
                  searchText: state.searchText));
              Future.delayed(const Duration(milliseconds: 400), () {
                // Code sẽ chạy sau 2 giây
                Navigator.pop(context);
              });
            },
            text: "Bỏ chọn tất cả",
          ),
          Expanded(
            child: ListView.builder(
              controller:
                  scrollController, // Quan trọng: Gắn scrollController từ DraggableScrollableSheet
              itemCount: TypeModelList.count,
              itemBuilder: (context, index) {
                return ButtonSelectionItem(
                  leading:
                      state.types.contains(TypeModelList.allTypes[index].name)
                          ? TypeModelList.allTypes[index].backGround.svg()
                          : TypeModelList.allTypes[index].backGround
                              .svg(color: TypeModelList.allTypes[index].color),
                  text: TypeModelList.allTypes[index].name,
                  colorText:
                      state.types.contains(TypeModelList.allTypes[index].name)
                          ? Colors.white
                          : TypeModelList.allTypes[index].color,
                  colorBackGround:
                      state.types.contains(TypeModelList.allTypes[index].name)
                          ? TypeModelList.allTypes[index].color
                          : TypeModelList.allTypes[index].colorBackGround,
                  colorBorder: TypeModelList.allTypes[index].color,
                  onTap: () {
                    for (int i = 0; i < state.types.length; i++) {
                      duy.add(state.types[i]);
                    }
                    if (state.types
                        .contains(TypeModelList.allTypes[index].name)) {
                      duy.remove(TypeModelList.allTypes[index].name);
                    } else {
                      duy.add(TypeModelList.allTypes[index].name);
                    }

                    print(
                        "Search by hệ thống: ${TypeModelList.allTypes[index].name}");

                    context.read<HomeBloc>().add(HomeGetListPokemon(
                        start: 0,
                        count: 20,
                        type: duy,
                        sortByType: state.sortByType,
                        searchText: state.searchText));
                    Future.delayed(const Duration(milliseconds: 400), () {
                      // Code sẽ chạy sau 2 giây
                      Navigator.pop(context);
                    });
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class ButtonSelectionItem extends StatefulWidget {
  final Function() onTap;
  final Color colorBackGround;
  final String text;
  final Color colorBorder;
  final Widget? leading;
  final Color colorText;
  const ButtonSelectionItem({
    super.key,
    required this.onTap,
    this.leading,
    required this.text,
    this.colorText = Colors.white,
    this.colorBackGround = const Color(0xFF333333),
    this.colorBorder = const Color(0xFF333333),
  });

  @override
  State<ButtonSelectionItem> createState() => _ButtonSelectionItemState();
}

class _ButtonSelectionItemState extends State<ButtonSelectionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          margin: const EdgeInsets.all(5),
          // padding: const EdgeInsets.all(16),
          // width: MediaQuery.of(context).size.width - 32,
          height: 65,
          decoration: BoxDecoration(
              color: widget.colorBackGround,
              // color: listType[0].colorBackGround,
              border: Border.all(
                color: widget.colorBorder,
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                widget.leading ?? const SizedBox(),
                Center(
                    child: Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.colorText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))
              ],
            ),
          )),
    );
  }
}
