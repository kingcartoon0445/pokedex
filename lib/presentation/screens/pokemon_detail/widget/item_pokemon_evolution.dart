import 'package:flutter/widgets.dart';
import 'package:pokedex/core/number_formatter.dart';
import 'package:pokedex/core/string_formatter.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/pokemon_detail.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/widget/widget_item_mini_type.dart';

class ItemPokemonEvolution extends StatelessWidget {
  final Pokemon pokemon;
  bool ngang;
  ItemPokemonEvolution({super.key, required this.pokemon, required this.ngang});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      width: ngang ? null : 150,
      decoration: BoxDecoration(
        // color: Colors.red,
        // color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          width: SizeWidget.spaceWidgetBorder,
        ),
      ),
      child: ngang
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: SizeWidget.sizeMiniAvatarPokemon,
                  // height: 50, //
                  decoration: BoxDecoration(
                    color: TypeModel.getType(pokemon.type[0]).color,
                    // color: Colors.red,
                    // color: FlutterFlowTheme.of(context).secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child:
                            TypeModel.getType(pokemon.type[0]).backGround.svg(),
                      ),
                      Image.network(
                        pokemon.image,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SizeWidget.spaceWidgetMin),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringFormatter.capitalizeFirst(pokemon.name),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeWidget.sizeTextAverage),
                    ),
                    Text(
                      NumberFormatter.format(pokemon.id),
                      style: TextStyle(
                          color: const Color(0xFF4D4D4D),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeWidget.sizeTextTiny),
                    ),
                    SizedBox(height: SizeWidget.spaceWidgetMin),
                    Container(
                      margin: EdgeInsets.only(
                        right: SizeWidget.spaceWidgetMax,
                      ),
                      width: SizeWidget.sizeWidgetListItemMiniType(context),
                      height: 25,
                      child: Row(
                        children: [
                          for (int i = 0; i < pokemon.type.length; i++) ...[
                            Expanded(
                              child: WidgetItemMiniType(
                                typePokemon: TypeModel.getType(pokemon.type[i]),
                              ),
                            ),
                            SizedBox(
                              width: SizeWidget.spaceWidgetMin,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  // width:,
                  // height: 50, //
                  decoration: BoxDecoration(
                    color: TypeModel.getType(pokemon.type[0]).color,
                    // color: Colors.red,
                    // color: FlutterFlowTheme.of(context).secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child:
                            TypeModel.getType(pokemon.type[0]).backGround.svg(),
                      ),
                      Image.network(
                        pokemon.image,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SizeWidget.spaceWidgetMin),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringFormatter.capitalizeFirst(pokemon.name),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeWidget.sizeTextAverage),
                      ),
                      Text(
                        NumberFormatter.format(pokemon.id),
                        style: TextStyle(
                            color: const Color(0xFF4D4D4D),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeWidget.sizeTextTiny),
                      ),
                      SizedBox(height: SizeWidget.spaceWidgetMin),
                      SizedBox(
                        width: SizeWidget.sizeWidgetListItemMiniType(context),
                        height: 25,
                        child: Row(
                          children: [
                            for (int i = 0; i < pokemon.type.length; i++) ...[
                              Expanded(
                                child: WidgetItemMiniType(
                                  typePokemon:
                                      TypeModel.getType(pokemon.type[i]),
                                ),
                              ),
                              if (i != pokemon.type.length - 1) ...[
                                SizedBox(
                                  width: SizeWidget.spaceWidgetMin,
                                ),
                              ]
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
