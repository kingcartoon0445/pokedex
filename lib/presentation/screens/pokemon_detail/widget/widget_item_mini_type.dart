import 'package:flutter/material.dart';
import 'package:pokedex/data/models/type_model.dart';

class WidgetItemMiniType extends StatelessWidget {
  final TypeModel typePokemon;
  const WidgetItemMiniType({super.key, required this.typePokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        // color: Colors.red,
        color: typePokemon.color,
        // color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Center(
        child: typePokemon.icon.svg(fit: BoxFit.fitHeight, color: Colors.white),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     Container(
      //       // height: 30,
      //       // width: 30,
      //       padding: const EdgeInsets.all(5),
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         shape: BoxShape.circle,
      //       ),
      //       // child: widget.typeModel.icon.svg(),
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     const Text(
      //       " widget.typeModel.name",
      //       style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: Colors.black),
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //   ],
      // ),
    );
  }
}
