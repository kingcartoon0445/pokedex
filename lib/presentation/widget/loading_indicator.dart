import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final String? message;
  final bool isOverlay;
  final Color? backgroundColor;

  const LoadingIndicator({
    Key? key,
    this.size = 36.0,
    this.color,
    this.strokeWidth = 4.0,
    this.message,
    this.isOverlay = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget loadingIndicator = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message!,
                style: TextStyle(
                  color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16.0,
                ),
              ),
            ),
        ],
      ),
    );

    if (isOverlay) {
      return Container(
        color: backgroundColor ?? Colors.black.withOpacity(0.5),
        child: loadingIndicator,
      );
    }

    return loadingIndicator;
  }

  // Factory constructor cho loading indicator toàn màn hình
  factory LoadingIndicator.fullScreen({
    Color? color,
    double size = 48.0,
    String? message,
    Color? backgroundColor,
  }) {
    return LoadingIndicator(
      size: size,
      color: color,
      message: message,
      isOverlay: true,
      backgroundColor: backgroundColor,
    );
  }
}
