import 'package:flutter/material.dart';
import 'package:pokedex/generated/assets.gen.dart';

class LightningStrikeAnimation extends StatefulWidget {
  const LightningStrikeAnimation({Key? key}) : super(key: key);

  @override
  _LightningStrikeAnimationState createState() =>
      _LightningStrikeAnimationState();
}

class _LightningStrikeAnimationState extends State<LightningStrikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Animation Controller kéo dài 800ms, có thể điều chỉnh theo ý bạn
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animation di chuyển từ -1 (trên màn hình) xuống vị trí ban đầu (0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Animation mờ tăng dần (fade in) cho hiệu ứng bóng sét
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Bắt đầu animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Stack để có thể vẽ hiệu ứng trên nền trang
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Assets.images.types.bug.svg(), // Đường dẫn file SVG của bạn
          ),
        ),
      ),
    );
  }
}
