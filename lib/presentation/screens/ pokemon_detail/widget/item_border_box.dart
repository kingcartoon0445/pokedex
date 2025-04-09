import 'package:pokedex/import_global.dart';

class ItemBorDerBox extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  const ItemBorDerBox(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(
              width: 5,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: (MediaQuery.sizeOf(context).width - 48) / 2,
          // height: 55,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: FlutterFlowTheme.of(context).secondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
