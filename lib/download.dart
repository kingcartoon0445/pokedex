import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex/import_global.dart';

import 'package:http/http.dart' as http;
import 'package:pokedex/presentation/screens/home/home_screen.dart';

class DownloadSplashScreen extends StatefulWidget {
  const DownloadSplashScreen({super.key});

  @override
  _DownloadSplashScreenState createState() => _DownloadSplashScreenState();
}

class _DownloadSplashScreenState extends State<DownloadSplashScreen> {
  final bool _isLoading = true;
  double _downloadProgress = 0.0;
  String _statusMessage = "Đang khởi tạo...";
  final List<String> _dataToDownload = [
    "https://example.com/api/data1",
    "https://example.com/api/data2",
    "https://example.com/api/data3",
  ];
  int _downloadedCount = 0;

  @override
  void initState() {
    super.initState();
    _startDownloading();
  }

  Future<void> _startDownloading() async {
    // Check if we need to download or can use cached data
    final prefs = await SharedPreferences.getInstance();
    final lastDownloadTime = prefs.getString('last_download_time');
    final currentTime = DateTime.now().toString();

    // Kiểm tra xem có cần tải lại dữ liệu không
    // Ví dụ: Nếu đã tải trong vòng 24 giờ trước đó, có thể bỏ qua
    bool needDownload = true;
    if (lastDownloadTime != null) {
      final lastTime = DateTime.parse(lastDownloadTime);
      final diffHours = DateTime.now().difference(lastTime).inHours;
      needDownload = diffHours > 24; // Tải lại sau 24 giờ
    }

    if (needDownload) {
      setState(() {
        _statusMessage = "Đang tải dữ liệu...";
      });

      await _downloadAllData();

      // Lưu thời gian tải xuống
      await prefs.setString('last_download_time', currentTime);
    } else {
      setState(() {
        _statusMessage = "Đang tải dữ liệu từ bộ nhớ đệm...";
        _downloadProgress = 1.0;
      });
      // Giả lập thời gian tải từ bộ nhớ cache
      await Future.delayed(const Duration(seconds: 1));
    }

    // Chuyển đến màn hình chính sau khi tải xong
    navigateToMainScreen();
  }

  Future<void> _downloadAllData() async {
    for (int i = 0; i < _dataToDownload.length; i++) {
      final url = _dataToDownload[i];
      setState(() {
        _statusMessage = "Đang tải ${i + 1}/${_dataToDownload.length}...";
      });

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Lưu dữ liệu vào SharedPreferences hoặc local database
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('data_${i + 1}', response.body);

          // Cập nhật tiến trình
          _downloadedCount++;
          setState(() {
            _downloadProgress = _downloadedCount / _dataToDownload.length;
          });

          // Tạo độ trễ giả lập cho demo
          await Future.delayed(const Duration(milliseconds: 800));
        } else {
          setState(() {
            _statusMessage = "Lỗi tải dữ liệu ${i + 1}: ${response.statusCode}";
          });
          // Xử lý lỗi: có thể thử lại hoặc bỏ qua
          await Future.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        setState(() {
          _statusMessage = "Lỗi kết nối: $e";
        });
        // Xử lý lỗi: có thể thử lại hoặc bỏ qua
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  void navigateToMainScreen() {
    // Chuyển đến màn hình chính sau khi hoàn tất tải xuống
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            const Text(
              "App Name",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: _downloadProgress,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${(_downloadProgress * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Màn hình chính"),
      ),
      body: const Center(
        child: Text("Đã tải xong dữ liệu và vào ứng dụng!"),
      ),
    );
  }
}
