import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_bloc.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_event.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_state.dart';
import 'package:pokedex/presentation/screens/home/widget/item_pokemon.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/widget/widget_skill.dart';
import 'package:animations/animations.dart';

class WaterElementScreen extends StatefulWidget {
  final TypeModel typeModel;
  const WaterElementScreen({super.key, required this.typeModel});
  @override
  _WaterElementScreenState createState() => _WaterElementScreenState();
}

class _WaterElementScreenState extends State<WaterElementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_handleScroll);
    context
        .read<TypeDetailBloc>()
        .add(GetTypeDetai(typeIdOrName: widget.typeModel.name));
  }

  bool _isCollapsed = false;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    double collapseOffset = 450 - // expandedHeight
        (kToolbarHeight + 135); // chiều cao AppBar + TabBar

    bool isCollapsedNow = _scrollController.offset >= collapseOffset;

    if (isCollapsedNow != _isCollapsed) {
      setState(() {
        _isCollapsed = isCollapsedNow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TypeDetailBloc, TypeDetailState>(
          builder: (context, state) {
        return NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 450.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      widget.typeModel.color,
                      widget.typeModel.color.withOpacity(0.5),
                    ],
                    stops: const [0, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SizedBox(
                    height: 315,
                    child: Center(
                        child: widget.typeModel.backGround.svg(
                            color: _isCollapsed ? Colors.transparent : null))),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(135),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hệ ${widget.typeModel.name}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Elemento fundamental',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //Vị trí 1
                              PageTransitionSwitcher(
                                duration: const Duration(milliseconds: 400),
                                reverse: _isCollapsed,
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                ) {
                                  return SharedAxisTransition(
                                    animation: animation,
                                    secondaryAnimation: secondaryAnimation,
                                    transitionType:
                                        SharedAxisTransitionType.horizontal,
                                    child: child,
                                  );
                                },
                                child: !_isCollapsed
                                    ? WidgetItemType(
                                        key: const ValueKey('show'),
                                        typeModel: widget.typeModel,
                                        scale: 1.2,
                                      )
                                    : const SizedBox(
                                        key: ValueKey('hide'),
                                        width: 0,
                                        height: 0,
                                      ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ), // //Vị trí 2
                          const Spacer(),
                          PageTransitionSwitcher(
                            duration: const Duration(milliseconds: 400),
                            reverse: !_isCollapsed,
                            transitionBuilder: (
                              Widget child,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                            ) {
                              return SharedAxisTransition(
                                animation: animation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                            child: _isCollapsed
                                ? WidgetItemType(
                                    key: const ValueKey('show'),
                                    typeModel: widget.typeModel,
                                    scale: 1.2,
                                  )
                                : const SizedBox(
                                    key: ValueKey('hide'),
                                    width: 0,
                                    height: 0,
                                  ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      TabBar(
                        padding: const EdgeInsets.all(0),
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: widget.typeModel.color,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: widget.typeModel.color,
                        tabs: const [
                          Tab(text: 'Thông tin'),
                          Tab(text: 'Kỹ năng'),
                          Tab(text: 'Danh sách Pokemon'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tab content
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              // Descrição tab
              CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Conteúdo da descrição...'),
                        // Thêm nội dung tab Descrição ở đây
                      ]),
                    ),
                  ),
                ],
              ),
              // Características tab
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số cột trong lưới
                    crossAxisSpacing: 10, // Khoảng cách giữa các cột
                    mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                    childAspectRatio: 3,
                  ),
                  itemCount:
                      state.listMoves == null ? 0 : state.listMoves!.length,
                  itemBuilder: (context, index) {
                    return WidgetSkill(
                      scale: 1,
                      name: state.listMoves![index].name,
                      typeModel:
                          TypeModel.getType(state.listMoves![index].type),
                    );
                  },
                ),
              ),

              // Movimentos tab

              ListView.builder(
                itemBuilder: (context, index) {
                  final pokemonList = state.listPokemon ?? [];
                  if (index == pokemonList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final pokemon = pokemonList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ItemPokemon(
                      pokemon: pokemon,
                    ),
                  );
                },
                itemCount: state.listPokemon == null
                    ? 0
                    : state.listPokemon!.length +
                        (state.status == BlocPokemonStatus.loading ? 1 : 0),
              )
            ],
          ),
        );
      }),
    );
  }
}
