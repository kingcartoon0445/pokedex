import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/import_global.dart';

class WidgetItemType extends StatefulWidget {
  final TypeModel typeModel;
  const WidgetItemType({super.key, required this.typeModel});

  @override
  State<WidgetItemType> createState() => _WidgetItemTypeState();
}

class _WidgetItemTypeState extends State<WidgetItemType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 35,
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
            height: 20,
            width: 20,
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
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
