import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/config/routes.dart';
import 'package:pokedex/core/number_formatter.dart';
import 'package:pokedex/core/string_formatter.dart';
import 'package:pokedex/data/model_db/evolution_chain_model.dart';
import 'package:pokedex/data/model_db/moves_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/import_global.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_event.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/detail_pokemon_model.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/widget/item_border_box.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/widget/item_pokemon_evolution.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/widget/widget_skill.dart';
import 'package:pokedex/presentation/screens/home/widget/item_pokemon.dart';
import 'package:pokedex/presentation/widget/loading_indicator.dart';
import 'package:pokedex/presentation/widget/read_more.dart';

class SizeWidget {
  static double spaceWidgetBorder = 1;
  static double spaceWidgetMin = 5;
  static double spaceWidgetMax = 16;
  static double sizeTextMin = 13;
  static double sizeTextTiny = 14;
  static double sizeTextMedium = 16;
  static double sizeTextAverage = 18;
  static double sizeTextImmense = 20;
  static double sizeTextVast = 34;
  static double sizeMiniAvatarPokemon = 100;
  static double sizeBackgroundPokemonDetail(BuildContext context) =>
      MediaQuery.sizeOf(context).width - 40;

  static double sizeWidgetListItemMiniType(BuildContext context) =>
      MediaQuery.sizeOf(context).width -
      // padding width cơ bản của app
      spaceWidgetMax * 2 -
      // padding width  của avatar mini pokemon
      sizeMiniAvatarPokemon -
      // padding width của khung tổng
      spaceWidgetMax * 2 -
      // padding width của widget
      spaceWidgetMin * 1 -
      spaceWidgetMax -
      //border width của khung ngoài
      spaceWidgetBorder * 2 -
      //border width của khung trong
      spaceWidgetBorder * 2;
  static double sizeImagePokemon = 200;
}

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  final List<TypeModel> listType;
  const PokemonDetail(
      {super.key, required this.pokemon, required this.listType});

  @override
  Widget build(BuildContext context) {
    context
        .read<PokemonDetailBloc>()
        .add(PokemonDetailGetAllDetail(pokemon: pokemon, id: pokemon.id));
    return Material(
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeWidget.sizeBackgroundPokemonDetail(
                          context), // MediaQuery.sizeOf(context).width + 20, //rồi
                      child: Stack(
                        children: [
                          //Nền màu hệ chính của Pokemon
                          Container(
                            height: MediaQuery.sizeOf(context).width - 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  listType[0].color,
                                  listType[0].color.withOpacity(0.5),
                                ],
                                stops: const [0, 1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              // color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            // Nền ảnh chính hệ Pokemon
                            child: Center(
                                child: listType[0].backGround.svg(
                                    height: SizeWidget.sizeImagePokemon,
                                    width: SizeWidget.sizeImagePokemon)), //rồi
                          ),
                          // Hình Pokemon
                          Hero(
                            tag: 'pokemon-${pokemon.id}',
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.network(
                                pokemon.image,
                                // height: 45,
                                fit: BoxFit.fitHeight,
                                height: SizeWidget.sizeImagePokemon,
                                // height: MediaQuery.sizeOf(context).width / 2,
                                // width: 250,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tên Pokemon
                          Text(
                            StringFormatter.capitalizeFirst(
                                pokemon.name ?? "Pikachu"),
                            style: TextStyle(
                                fontSize: SizeWidget.sizeTextVast,
                                fontWeight: FontWeight.w600), //rồi
                          ),
                          SizedBox(
                            height: SizeWidget.spaceWidgetMin,
                          ),
                          // Mã Pokemon
                          Text(
                            NumberFormatter.format(pokemon.id ?? 0),
                            style: TextStyle(
                                fontSize: SizeWidget.spaceWidgetMax,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(0, 0, 0, 0.7)),
                          ),
                          SizedBox(height: SizeWidget.spaceWidgetMin),
                          // Hệ của Pokemon
                          Row(
                            children: [
                              for (int i = 0; i < listType.length; i++) ...[
                                WidgetItemType(
                                  scale: 1.2,
                                  typeModel: listType[i],
                                ),
                                if (listType.length - 1 != i) ...[
                                  SizedBox(width: SizeWidget.spaceWidgetMin)
                                ]
                              ],
                            ],
                          ),
                          SizedBox(height: SizeWidget.spaceWidgetMin),
                          // Mô tả trong pokedex
                          BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
                              builder: (context, state) {
                            if (state.status == BlocPokemonStatus.loading ||
                                state.detailPokemonModel == null) {
                              return const Center(child: LoadingIndicator());
                            }
                            DetailPokemonModel detailPokemonModel =
                                state.detailPokemonModel!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SimpleReadMoreText(
                                  text: state.detailPokemonModel != null
                                      ? state.detailPokemonModel!.describe!
                                              .replaceAll("\n", " ")
                                              .replaceAll("\f", " ") ??
                                          ""
                                      : "",
                                  trimLines: 1,
                                  readMoreText: 'Xem thêm',
                                  readLessText: 'Thu gọn',
                                  style: TextStyle(
                                      fontSize: SizeWidget.sizeTextMedium),
                                  readMoreStyle: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                  animationDuration:
                                      const Duration(milliseconds: 400),
                                ),

                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                Text(
                                  "Base stats".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: SizeWidget.sizeTextAverage,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                CustomProgressBar1(
                                  text: "Hp",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.hp
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                CustomProgressBar1(
                                  text: "Attack",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.attack
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                CustomProgressBar1(
                                  text: "Defense",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.defense
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                CustomProgressBar1(
                                  text: "Sp. Atk",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.specialAttack
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                CustomProgressBar1(
                                  text: "Sp. Def",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.specialDefense
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                CustomProgressBar1(
                                  text: "Speed",
                                  value: int.parse(detailPokemonModel
                                      .pokemon!.speed
                                      .toString()),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: SizeWidget.spaceWidgetMin,
                                      ),
                                      const Spacer(),
                                      Text(
                                        detailPokemonModel.pokemon!.total
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: SizeWidget.spaceWidgetMin,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: SizeWidget.spaceWidgetMin,
                                ),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                //Chiều cao và cân nặng pokemon
                                Row(
                                  children: [
                                    ItemBorDerBox(
                                      icon: Assets.images.icons.weight.svg(),
                                      title: "weight",
                                      value:
                                          "${NumberFormatter.formatDouble(pokemon.weight)} kg",
                                    ),
                                    SizedBox(
                                      width: SizeWidget.sizeTextMedium,
                                    ),
                                    ItemBorDerBox(
                                      icon: Assets.images.icons.height.svg(),
                                      title: "height",
                                      value:
                                          "${NumberFormatter.formatDouble(pokemon.height)} m",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                // loại và loại trứng pokemon
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ItemBorDerBox(
                                      icon: Assets.images.icons.species.svg(),
                                      title: "species",
                                      value: detailPokemonModel.species ?? "",
                                    ),
                                    SizedBox(
                                      width: SizeWidget.spaceWidgetMax,
                                    ),
                                    ItemBorDerBox(
                                      icon: Assets.images.icons.eggGroups.svg(),
                                      title: "egg Groups",
                                      value: detailPokemonModel.eggGroups!
                                          .join(", "),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                Center(
                                  child: Text(
                                    "Giới tính".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: SizeWidget.sizeTextTiny),
                                  ),
                                ),

                                SizedBox(height: SizeWidget.spaceWidgetMin),

                                if (detailPokemonModel.genderRate == -1) ...[
                                  Center(
                                    child: Text(
                                      "Genderless".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: SizeWidget.sizeTextTiny),
                                    ),
                                  ),
                                ] else ...[
                                  CustomProgressBar(
                                    value: 1 -
                                        detailPokemonModel.genderRate! / 100,
                                  ),
                                ],
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Skill".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: SizeWidget.sizeTextAverage,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        showAllItems(context,
                                            detailPokemonModel.listMoves!);
                                      },
                                      child: const Text(
                                        "Xem thêm",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                // detailPokemonModel.moves[0].move.
                                SizedBox(
                                  // height: 200,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Số cột trong lưới
                                      crossAxisSpacing:
                                          10, // Khoảng cách giữa các cột
                                      mainAxisSpacing:
                                          10, // Khoảng cách giữa các hàng
                                      childAspectRatio:
                                          3, // Tỉ lệ chiều rộng / chiều cao của item
                                    ),
                                    itemCount: detailPokemonModel
                                                .listMoves!.length >
                                            4
                                        ? 4
                                        : detailPokemonModel.listMoves!
                                            .length, // Số lượng item trong danh sách
                                    itemBuilder: (context, index) {
                                      return WidgetSkill(
                                        scale: 1,
                                        name: detailPokemonModel
                                            .listMoves![index].name,
                                        typeModel: TypeModel.getType(
                                            detailPokemonModel
                                                .listMoves![index].type),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                Text(
                                  "Evolution".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: SizeWidget.sizeTextAverage,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: SizeWidget.spaceWidgetMax,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.all(SizeWidget.spaceWidgetMax),
                                  decoration: BoxDecoration(
                                    // color: FlutterFlowTheme.of(context).secondary,
                                    // color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                                      width: SizeWidget.spaceWidgetBorder,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      buildItemEvolution(
                                          detailPokemonModel
                                              .evolutionChainModel!.chain!,
                                          checkStyleWidget(detailPokemonModel
                                              .evolutionChainModel!.chain!),
                                          context),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 25, left: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ))

              // Scaffold(
              //   backgroundColor: Colors.transparent,
              //   appBar: AppBar(
              //     backgroundColor: Colors.transparent,
              //   ),
              // ),
            ],
          )),
    );
  }
}

void showAllItems(BuildContext context, List<Moves> moves) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        height:
            MediaQuery.of(context).size.height * 0.7, // Chiều cao bottom sheet
        child: Column(
          children: [
            Text(
              "Skill".toUpperCase(),
              style: TextStyle(
                  fontSize: SizeWidget.sizeTextAverage,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột trong lưới
                  crossAxisSpacing: 10, // Khoảng cách giữa các cột
                  mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                  childAspectRatio: 3,
                ),
                itemCount: moves.length,
                itemBuilder: (context, index) {
                  return WidgetSkill(
                    scale: 1,
                    name: moves[index].name,
                    typeModel: TypeModel.getType(moves[index].type),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

bool checkStyleWidget(EvolvesTo evolvesTo) {
  bool ischeck = true;
  if (evolvesTo.evolvesTo!.length > 1) {
    ischeck = false;
  } else {
    if (evolvesTo.evolvesTo!.length == 1) {
      ischeck = checkStyleWidget(evolvesTo.evolvesTo![0]);
    }
  }
  return ischeck;
}

Widget buildItemEvolution(
    EvolvesTo evolvesTo, bool ngang, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      WidgetDad(evolvesTo),
      SizedBox(
        height: SizeWidget.spaceWidgetMax,
      ),
      evolvesTo.pokemon != null
          ? InkWell(
              onTap: () {
                final List<TypeModel> listType = [];
                for (int i = 0; i < evolvesTo.pokemon!.type.length; i++) {
                  listType
                      .add(TypeModel.getType(evolvesTo.pokemon!.type[i] ?? ""));
                }
                Navigator.of(context).pushReplacement(CreateRoute(
                  PokemonDetail(
                    listType: listType,
                    pokemon: evolvesTo.pokemon!,
                  ),
                ));
              },
              child: ItemPokemonEvolution(
                ngang: ngang,
                pokemon: evolvesTo.pokemon!,
              ),
            )
          : const SizedBox(),
      SizedBox(
        height: SizeWidget.spaceWidgetMax,
      ),
      if (evolvesTo.evolvesTo != null) ...[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < evolvesTo.evolvesTo!.length; i++) ...[
                Center(
                    child: buildItemEvolution(
                        evolvesTo.evolvesTo![i], ngang, context)),
                if (i != evolvesTo.evolvesTo!.length - 1) ...[
                  SizedBox(
                    width: SizeWidget.spaceWidgetMin,
                  ),
                ]
              ]
            ],
          ),
        )
      ]
    ],
  );
}

WidgetDad(EvolvesTo chain) {
  if (chain.trigger == "trade") {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Assets.images.icons.tradeIcon.svg(height: 25),
        const Text("+"),
        getHowEvolution(chain, true)
      ],
    );
  } else {
    return getHowEvolution(chain, false);
  }
}

Widget getHowEvolution(EvolvesTo chain, bool notShowArrow) {
  if (chain.minLevel != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Text(
          "Level ${chain.minLevel!}",
          style: TextStyle(fontSize: SizeWidget.sizeTextMedium),
        )
      ],
    );
  }
  if (chain.heldItem != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/${chain.heldItem}.png")
      ],
    );
  }
  if (chain.item != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/${chain.item}.png")
      ],
    );
  }
  if (chain.known_move != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Text(
          "Known move ${StringFormatter.capitalizeFirst(chain.known_move ?? "")}",
          style: TextStyle(fontSize: SizeWidget.sizeTextMedium),
        )
      ],
    );
  }
  if (chain.known_move_type != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Text(
          "Known move type ${StringFormatter.capitalizeFirst(chain.known_move_type ?? "")}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SizeWidget.sizeTextMedium,
              color: TypeModel.getType("fairy").color),
        )
      ],
    );
  }
  if (chain.min_happiness != null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        notShowArrow ? const SizedBox() : Assets.images.icons.downArrow.svg(),
        SizedBox(
          width: SizeWidget.spaceWidgetMin,
        ),
        Text(
          chain.time_of_day != ""
              ? "Happiness ${chain.min_happiness} and ${chain.time_of_day}"
              : "Happiness ${chain.min_happiness}",
          style: TextStyle(fontSize: SizeWidget.sizeTextMedium),
        )
      ],
    );
  }

  return const SizedBox();
}

class CustomProgressBar extends StatelessWidget {
  final double value; // Giá trị tiến trình từ 0.0 đến 1.0

  const CustomProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width - 32;
    return Column(
      children: [
        Container(
          width: width,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFFFF7596), // Màu viền của thanh progress
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Container(
                width: width * value,
                decoration: const BoxDecoration(
                  color: Color(0xFF2551C3),
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(5)),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.male_outlined,
                color: Color.fromRGBO(0, 0, 0, 0.7)),
            SizedBox(width: SizeWidget.spaceWidgetMin),
            Text(
              "${value * 100}%",
              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.7)),
            ),
            const Spacer(),
            const Icon(Icons.female_outlined,
                color: Color.fromRGBO(0, 0, 0, 0.7)),
            SizedBox(width: SizeWidget.spaceWidgetMin),
            Text(
              "${(1 - value) * 100}%",
              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.7)),
            )
          ],
        )
      ],
    );
  }
}

class CustomProgressBar1 extends StatelessWidget {
  final String text;
  final int value; // Giá trị tiến trình từ 0.0 đến 1.0

  const CustomProgressBar1(
      {super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    Color buildColor = const Color(0xFF2551C3);
    if (value < 60) {
      buildColor = const Color(0xFFEF8636);
    } else if (value < 90) {
      buildColor = const Color(0xFFF9DE6E);
    } else {
      buildColor = const Color(0xFF62CA6B);
    }
    double width = MediaQuery.sizeOf(context).width - 32 - 100;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey)),
                  SizedBox(
                    width: SizeWidget.spaceWidgetMin,
                  ),
                  const Spacer(),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  SizedBox(
                    width: SizeWidget.spaceWidgetMin,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 255, 255, 255), // Màu viền của thanh progress
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: width * (value / 252),
                      decoration: BoxDecoration(
                        color: buildColor,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(5),
                            right: Radius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          width: double.infinity,
          color: const Color.fromARGB(128, 104, 104, 104),
        ),
      ],
    );
  }
}
