import 'package:pokedex/config/routes.dart';
import 'package:pokedex/core/number_formatter.dart';
import 'package:pokedex/core/string_formatter.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/import_global.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/pokemon_detail.dart';
import 'package:pokedex/presentation/screens/type_detail/type_detail_screen.dart';

class ItemPokemon extends StatelessWidget {
  final Pokemon pokemon;
  const ItemPokemon({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final List<TypeModel> listType = [];
    for (int i = 0; i < pokemon.type.length; i++) {
      listType.add(TypeModel.getType(pokemon.type[i] ?? ""));
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CreateRoute(
          PokemonDetail(
            listType: listType,
            pokemon: pokemon,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 120,
              decoration: BoxDecoration(
                  color: listType[0].colorBackGround,
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        NumberFormatter.format(pokemon.id ?? 0),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333)),
                      ),
                      Text(
                        StringFormatter.capitalizeFirst(pokemon.name ?? ""),
                        style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < listType.length; i++) ...[
                            WidgetItemType(
                              typeModel: listType[i],
                            ),
                            if (listType.length - 1 != i) ...[
                              const SizedBox(
                                width: 5,
                              )
                            ]
                          ],
                        ],
                      )
                    ],
                  )),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: listType[0].color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Center(child: listType[0].backGround.svg()),
                        Hero(
                          tag: 'pokemon-${pokemon.id}',
                          child: Center(
                            child: Image.network(pokemon.image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.icons.noLove.svg(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetItemType extends StatefulWidget {
  final TypeModel typeModel;
  final double scale;
  const WidgetItemType({super.key, required this.typeModel, this.scale = 1});

  @override
  State<WidgetItemType> createState() => _WidgetItemTypeState();
}

class _WidgetItemTypeState extends State<WidgetItemType> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WaterElementScreen(
                    typeModel: widget.typeModel,
                  )),
        );
      },
      child: Container(
        width: 100 * widget.scale,
        height: 35 * widget.scale,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.typeModel.color,
          // color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 20 * widget.scale,
              width: 20 * widget.scale,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: widget.typeModel.icon.svg(),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.typeModel.name,
                  style: TextStyle(
                      fontSize: 14 * widget.scale,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
