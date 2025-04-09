import 'package:flutter/material.dart';
import 'package:pokedex/data/models/type_model.dart';

class TypeDetailScreen extends StatelessWidget {
  const TypeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TypeModelList.bug.color,
                TypeModelList.bug.colorBackGround,
              ],
              stops: const [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // color: FlutterFlowTheme.of(context).secondary,
          ),
          // Nền ảnh chính hệ Pokemon
          child: Center(
              child: TypeModelList.bug.backGround
                  .svg(height: 200, width: 200)), //rồi
        ),
        Scaffold(
          appBar: AppBar(),
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }
}
