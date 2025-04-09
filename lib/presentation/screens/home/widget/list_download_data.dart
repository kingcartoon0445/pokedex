import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/home/home_event.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';

class ListDownloadData extends StatelessWidget {
  final ScrollController scrollController; // Khởi tạo ScrollController
  const ListDownloadData({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.listGenerationModel == null) {
        return const CircularProgressIndicator();
      }
      return ListView.builder(
        controller:
            scrollController, // Quan trọng: Gắn scrollController từ DraggableScrollableSheet
        itemCount: state.listGenerationModel!.length,
        itemBuilder: (context, index) {
          final generationModel = state.listGenerationModel![index];
          return InkWell(
            onTap: () {
              context.read<HomeBloc>().add(HomeDownLoadDataPokemonData(
                  start: 1, id: generationModel.id));
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              // padding: const EdgeInsets.all(16),
              // width: MediaQuery.of(context).size.width - 32,
              height: 100,
              decoration: BoxDecoration(

                  // color: listType[0].colorBackGround,

                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                              "assets/images/generation/backgrounded_gen_${generationModel.id}.png")
                          .image),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                          // color: Colors.black.withOpacity(0.05),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0.8),
                              Color.fromRGBO(0, 0, 0, 0.15),
                            ],
                          ),
                          // color: listType[0].colorBackGround,

                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              generationModel.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Text(
                              "${generationModel.id}º Generation",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        if (state.downloadDataPokemonStatus ==
                                HomeStatus.loading &&
                            state.idGenDown == generationModel.id) ...[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  LinearProgressIndicator(
                                    color: Colors.green,
                                    backgroundColor: Colors.white,
                                    value: state.totalItems > 0
                                        ? state.currentIndex / state.totalItems
                                        : null,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Đang tải: ${(state.currentIndex / state.totalItems * 100).ceil()} %',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ] else ...[
                          const Spacer(),
                          if (generationModel.downloaded == true) ...[
                            // Text(
                            //   state.downloadDataPokemonStatus
                            //       .toString(),
                            //   style: const TextStyle(
                            //       color: Colors.white),
                            // ),
                            const Icon(Icons.check_circle_rounded,
                                color: Colors.white),
                          ] else ...[
                            const Icon(Icons.cloud_download_sharp,
                                color: Colors.white),
                          ]
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
