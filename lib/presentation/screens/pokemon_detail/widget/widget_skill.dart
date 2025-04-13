import 'package:pokedex/core/string_formatter.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/import_global.dart';

class WidgetSkill extends StatefulWidget {
  final TypeModel typeModel;
  final String name;
  final double scale;
  const WidgetSkill(
      {super.key, required this.name, required this.typeModel, this.scale = 1});

  @override
  State<WidgetSkill> createState() => _WidgetSkillState();
}

class _WidgetSkillState extends State<WidgetSkill> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth / 2,
        height: 45 * widget.scale,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.typeModel.color,
          // color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 30 * widget.scale,
              width: 30 * widget.scale,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: widget.typeModel.icon.svg(),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                StringFormatter.capitalizeFirst(widget.name),
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16 * widget.scale,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      );
    });
  }
}
