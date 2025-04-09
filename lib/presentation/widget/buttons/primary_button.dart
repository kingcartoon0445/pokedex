import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? theme.disabledColor
              : backgroundColor ?? theme.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2.0,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16.0,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    Icon(suffixIcon, size: 20),
                  ],
                ],
              ),
      ),
    );
  }

  // Factory constructors cho các trường hợp sử dụng phổ biến

  // Button nhỏ
  factory PrimaryButton.small({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Color? backgroundColor,
    Color? textColor,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: 120.0,
      height: 40.0,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  // Button dạng outline
  factory PrimaryButton.outline({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? height,
    IconData? prefixIcon,
    IconData? suffixIcon,
    double? fontSize,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width ?? double.infinity,
      height: height ?? 50.0,
      backgroundColor: Colors.transparent,
      textColor: textColor,
      fontSize: fontSize ?? 16.0,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
