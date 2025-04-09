import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/app.dart';
import 'package:pokedex/data/datasources/local/database_db.dart';
import 'package:pokedex/dio/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  await setupServiceLocator();

  // Khởi tạo đa ngôn ngữ
  await EasyLocalization.ensureInitialized();

  // Cố định hướng màn hình (tùy chọn)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final List<String> _items =
      List.generate(100, (index) => 'Item ${index + 1}');
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _navigateToDetail(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailScreen(itemIndex: index),
      ),
    );

    if (result != null && result is int) {
      // Scroll tới item được truyền về
      _scrollToIndex(result);
    }
  }

  void _scrollToIndex(int index) {
    const itemHeight = 60.0; // chiều cao ước tính của mỗi item
    final position = index * itemHeight;

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length,
        itemExtent: 60.0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]),
            onTap: () => _navigateToDetail(index),
          );
        },
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final int itemIndex;

  const ItemDetailScreen({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết item $itemIndex')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Quay lại và scroll đến item 52'),
          onPressed: () {
            Navigator.pop(context, 52); // Trả về index để scroll tới
          },
        ),
      ),
    );
  }
}
