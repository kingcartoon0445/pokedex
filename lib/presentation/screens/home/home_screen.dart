import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_event.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';
import 'package:pokedex/presentation/screens/home/widget/bottom_sheet_custom.dart';
import 'widget/item_pokemon.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   final bool _isLoading = false;

//   // Các items trong bottom navigation bar
//   final List<Map<String, dynamic>> _navItems = [
//     {'icon': Icons.home, 'label': 'Home'},
//     {'icon': Icons.explore, 'label': 'Explore'},
//     {'icon': Icons.notifications, 'label': 'Notifications'},
//     {'icon': Icons.person, 'label': 'Profile'},
//   ];

//   // Các widget tương ứng với mỗi tab
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const Center(child: Text('Explore Content')),
//     const Center(child: Text('Notifications Content')),
//     const Center(child: Text('Profile Content')),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//             if (state.downloadDataPokemonStatus == HomeStatus.loaded) {
//               context
//                   .read<HomeBloc>()
//                   .add(const HomeGetListPokemon(start: 1, count: 20));
//             }
//             return IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 _showDraggableBottomSheet(state);
//               },
//             );
//           }),
//         ],
//       ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               _screens[_selectedIndex],
//               if (_isLoading)
//                 LoadingIndicator.fullScreen(
//                   message: 'Loading...',
//                 ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: _navItems
//             .map((item) => BottomNavigationBarItem(
//                   icon: Icon(item['icon']),
//                   label: item['label'],
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _appBarHeight = 65.0;
  final double _appBarMinHeight = 80.0;
  final TextEditingController _searchController = TextEditingController();
  bool _isExpanded = true;
  @override
  void initState() {
    super.initState();
    // context.read<HomeBloc>().add(HomeGetListPokemon(start: 1, count: 59));
    // Khởi tạo dữ liệu
    context.read<HomeBloc>().add(const HomeGetListPokemon(start: 0, count: 20));

    // Thêm listener để phát hiện khi scroll đến cuối danh sách
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isExpanded =
        _scrollController.offset <= _appBarHeight - _appBarMinHeight;
    if (isExpanded != _isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
      });
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<HomeBloc>().state;

      if (state.status == HomeStatus.loaded) {
        final currentList = state.listPokemonModel;
        if (currentList != null &&
            state.listPokemonModel!.length < state.countSearch) {
          context.read<HomeBloc>().add(
                HomeGetListPokemon(
                  start: currentList.length,
                  searchText: state.searchText,
                  type: state.types,
                  count: 20,
                ),
              );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<HomeBloc>()
              .add(const HomeGetListPokemon(start: 0, count: 50));
        },
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state.downloadDataPokemonStatus == HomeStatus.loaded) {
            print("duy");
            context
                .read<HomeBloc>()
                .add(const HomeGetListPokemon(start: 0, count: 20));
          }
        }, builder: (context, state) {
          final pokemonList = state.listPokemonModel ?? [];

          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  sliver: SliverAppBar(
                    pinned: true,
                    toolbarHeight: 80,
                    expandedHeight: 65,
                    title: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              showDraggableBottomSheet(
                                  state,
                                  context,
                                  "Version Pokemon",
                                  StatusDraggableBottom.GENERATION);
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.grey.shade600,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                              onChanged: (value) {
                                context.read<HomeBloc>().add(HomeGetListPokemon(
                                    count: 20, start: 0, searchText: value));
                              },
                              decoration: InputDecoration(
                                hintText: "Procurar Pókemon...",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Chuyển đổi màu dựa trên trạng thái cuộn
                    backgroundColor: Colors.white,
                  ),
                ),

                // // Thanh tìm kiếm - luôn hiển thị
                // SliverPersistentHeader(
                //   delegate: PokemonSearchBarDelegate(),
                //   pinned: true,
                // ),

                // Bộ lọc - có thể ẩn hiện
                SliverPersistentHeader(
                  delegate: PokemonFilterDelegate(),
                  pinned: false,
                  floating: true,
                ),
                // // SliverAppBar với animation
                // SliverAppBar(
                //   pinned: true,
                //   expandedHeight: _appBarHeight,
                //   flexibleSpace: FlexibleSpaceBar(
                //     collapseMode: CollapseMode.pin,
                //     title: const PokemonSearchBar(),
                //     // title: const Text('ListView trong SliverList'),
                //     background: Image.network(
                //       'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   backgroundColor: _isExpanded ? Colors.transparent : Colors.blue,
                // ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (state.status == HomeStatus.loading) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: state.totalItems > 0
                                    ? state.currentIndex / state.totalItems
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Đang tải: ${state.currentIndex}/${state.totalItems}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Hiển thị thông báo lỗi nếu có
                      if (state.status == HomeStatus.error &&
                          state.error != null) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Đã xảy ra lỗi: ${state.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ],

                    // Danh sách Pokemon
                  ),
                ),
                pokemonList.isEmpty
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const Center(
                              child: Text(
                                  'Không có Pokemon nào. Kéo xuống để tải lại.'),
                            ),
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == pokemonList.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final pokemon = pokemonList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ItemPokemon(
                              pokemon: pokemon,
                            ),
                          );
                        },
                        childCount: pokemonList.length +
                            (state.status == HomeStatus.loading ? 1 : 0),
                      )),
                // Danh sách Pokemon

                // ListView.builder(
                //   physics: const NeverScrollableScrollPhysics(),
                //   controller: _scrollController, // Sử dụng controller đã khai báo
                //   padding: const EdgeInsets.all(16.0),
                //   itemCount: pokemonList.length +
                //       (state.status == HomeStatus.loading ? 1 : 0),
                //   itemBuilder: (context, index) {
                //     // Hiển thị indicator ở cuối danh sách khi đang tải thêm
                //     if (index == pokemonList.length) {
                //       return const Padding(
                //         padding: EdgeInsets.symmetric(vertical: 16.0),
                //         child: Center(child: CircularProgressIndicator()),
                //       );
                //     }

                //     final pokemon = pokemonList[index];
                //     return ItemPokemon(
                //       pokemon: pokemon,
                //     );
                //   },
                // )
              ],
            ),
          );
        }),
      ),
    );
    // return RefreshIndicator(
    //   onRefresh: () async {
    //     context
    //         .read<HomeBloc>()
    //         .add(const HomeGetListPokemon(start: 1, count: 50));
    //   },
    //   child: CustomScrollView(
    //     controller: _scrollController,
    //     physics: const BouncingScrollPhysics(),
    //     slivers: [
    //       SliverList(
    //         delegate: SliverChildListDelegate(
    //           [
    //             BlocConsumer<HomeBloc, HomeState>(
    //               listener: (context, state) {
    //                 if (state.downloadDataPokemonStatus == HomeStatus.loaded) {
    //                   print("duy");
    //                   context
    //                       .read<HomeBloc>()
    //                       .add(const HomeGetListPokemon(start: 1, count: 20));
    //                 }
    //               },
    //               builder: (context, state) {
    //                 final pokemonList = state.listPokemonModel ?? [];

    //                 return const Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // // Hiển thị tiến trình tải
    //                     // if (state.status == HomeStatus.loading) ...[
    //                     //   Padding(
    //                     //     padding: const EdgeInsets.symmetric(vertical: 12.0),
    //                     //     child: Column(
    //                     //       children: [
    //                     //         LinearProgressIndicator(
    //                     //           value: state.totalItems > 0
    //                     //               ? state.currentIndex / state.totalItems
    //                     //               : null,
    //                     //         ),
    //                     //         const SizedBox(height: 8),
    //                     //         Text(
    //                     //           'Đang tải: ${state.currentIndex}/${state.totalItems}',
    //                     //           style: const TextStyle(
    //                     //             fontSize: 14,
    //                     //             fontWeight: FontWeight.w500,
    //                     //           ),
    //                     //         ),
    //                     //       ],
    //                     //     ),
    //                     //   ),
    //                     // ],

    //                     // // Hiển thị thông báo lỗi nếu có
    //                     // if (state.status == HomeStatus.error &&
    //                     //     state.error != null) ...[
    //                     //   Padding(
    //                     //     padding: const EdgeInsets.all(16.0),
    //                     //     child: Text(
    //                     //       'Đã xảy ra lỗi: ${state.error}',
    //                     //       style: const TextStyle(color: Colors.red),
    //                     //     ),
    //                     //   ),
    //                     // ],

    //                     // // Danh sách Pokemon
    //                     // pokemonList.isEmpty
    //                     //     ? const Center(
    //                     //         child: Text(
    //                     //             'Không có Pokemon nào. Kéo xuống để tải lại.'),
    //                     //       )
    //                     //     : const Center(
    //                     //         child: Text(
    //                     //             '1 Không có Pokemon nào. Kéo xuống để tải lại.'),
    //                     //       ),
    //                   ],
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

Widget _buildSearchBar() {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.grey.shade300,
        width: 1.5,
      ),
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),
        Icon(
          Icons.search,
          color: Colors.grey.shade600,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: "Procurar Pókemon...",
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 18,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFilterButton(String text, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          icon,
          color: Colors.white,
        ),
      ],
    ),
  );
}

class PokemonSearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.only(),
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                onChanged: (value) {},
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: "Procurar Pókemon...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 92;

  @override
  double get minExtent => 92;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class PokemonFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterButton("Search with type", Icons.arrow_drop_down, () {
                showDraggableBottomSheet(
                    state, context, "theo hệ", StatusDraggableBottom.TYPE);
              }),
              _buildFilterButton(
                  state.sortByType != null ? state.sortByType!.text : 'Sort',
                  Icons.arrow_drop_down, () {
                showDraggableBottomSheet(state, context, "theo name hoặc id",
                    StatusDraggableBottom.SORTBY);
              }),
            ],
          );
        }),
      );
    });
  }

  Widget _buildFilterButton(String text, IconData icon, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
