import 'package:flutter/material.dart';

class SimpleReadMoreText extends StatefulWidget {
  final String text;
  final int trimLines;
  final String readMoreText;
  final String readLessText;
  final TextStyle? style;
  final TextStyle? readMoreStyle;
  final Duration animationDuration;

  const SimpleReadMoreText({
    Key? key,
    required this.text,
    this.trimLines = 3,
    this.readMoreText = 'Xem thêm',
    this.readLessText = 'Thu gọn',
    this.style,
    this.readMoreStyle,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _SimpleReadMoreTextState createState() => _SimpleReadMoreTextState();
}

class _SimpleReadMoreTextState extends State<SimpleReadMoreText>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  late Animation<double> _animation1;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _animation1 = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle =
        widget.style ?? Theme.of(context).textTheme.bodyMedium!;
    final TextStyle effectiveLinkStyle = widget.readMoreStyle ??
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);

    Widget collapsedText = Text(
      widget.text,
      style: effectiveTextStyle,
      maxLines: widget.trimLines,
      overflow: TextOverflow.ellipsis,
    );

    Widget expandedText = Text(
      widget.text,
      style: effectiveTextStyle,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stack(
        //   children: [
        //     Visibility(
        //       visible: !_isExpanded,
        //       child: collapsedText,
        //     ),
        //     Visibility(
        //       visible: _isExpanded,
        //       child: FadeTransition(
        //         opacity: _animation,
        //         child: expandedText,
        //       ),
        //     ),
        //   ],
        // ),
        AnimatedSize(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          child: Text(
            widget.text,
            style: effectiveTextStyle,
            maxLines: _isExpanded
                ? null
                : widget.trimLines, // Khi mở rộng thì không giới hạn dòng
            overflow: TextOverflow.fade, // Tránh hiệu ứng cắt gọn đột ngột
          ),
        ),
        // AnimatedSize(
        //   duration: widget.animationDuration,
        //   curve: Curves.easeInOut,
        //   child: Text(
        //     widget.text,
        //     style: effectiveTextStyle,
        //     maxLines: _isExpanded ? null : widget.trimLines,
        //     overflow: TextOverflow.fade,
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              if (_isExpanded) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Center(
              child: Text(
                _isExpanded ? widget.readLessText : widget.readMoreText,
                style: effectiveLinkStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
