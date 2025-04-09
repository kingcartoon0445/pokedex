import 'package:pokedex/import_global.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';
import 'package:pokedex/presentation/screens/home/widget/list_download_data.dart';
import 'package:pokedex/presentation/screens/home/widget/list_sort_selection.dart';
import 'package:pokedex/presentation/screens/home/widget/list_type_select.dart';

void showDraggableBottomSheet(HomeState state, BuildContext context,
    String title, StatusDraggableBottom statusDraggableBottom) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Quan trọng để BottomSheet có thể mở rộng toàn màn hình
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableBottomSheetContent(
      title: title,
      statusDraggableBottom: statusDraggableBottom,
    ),
  );
}

enum StatusDraggableBottom { TYPE, GENERATION, SORTBY }

class DraggableBottomSheetContent extends StatefulWidget {
  final String title;
  final StatusDraggableBottom statusDraggableBottom;
  const DraggableBottomSheetContent(
      {super.key, required this.title, required this.statusDraggableBottom});

  @override
  State<DraggableBottomSheetContent> createState() =>
      _DraggableBottomSheetContentState();
}

class _DraggableBottomSheetContentState
    extends State<DraggableBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Chiều cao ban đầu (50% màn hình)
      minChildSize: 0.2, // Chiều cao tối thiểu khi thu nhỏ (20% màn hình)
      maxChildSize: 0.95, // Chiều cao tối đa khi mở rộng (95% màn hình)
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Thanh kéo ở đầu bottom sheet
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Tiêu đề
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Nội dung có scrollable
              Expanded(
                  child:
                      widget.statusDraggableBottom == StatusDraggableBottom.TYPE
                          ? ItemStyleSelect(
                              scrollController: scrollController,
                            )
                          : widget.statusDraggableBottom ==
                                  StatusDraggableBottom.GENERATION
                              ? ListDownloadData(
                                  scrollController: scrollController,
                                )
                              : ListSortSelection(
                                  scrollController: scrollController,
                                )),
              // Các nút tác vụ ở cuối bottom sheet
            ],
          ),
        );
      },
    );
  }
}
