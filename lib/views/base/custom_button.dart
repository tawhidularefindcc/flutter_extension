import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../util/app_colors.dart';
import '../../util/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.gradient,
    this.textStyle,
    this.suffixIcon,
    this.iconSpacing = 8,
    this.radius,
    this.margin = EdgeInsets.zero,
    required this.onTap,
    required this.text,
    this.loading = false,
    this.enabled = true,
    this.width,
    this.height,
  });
  final Function() onTap;
  final String text;
  final bool loading;
  final bool enabled;
  final double? height;
  final double? width;
  final Color? color;
  final Gradient? gradient;
  final double? radius;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    final bool isInteractive = !loading && enabled;
    final double buttonRadius = radius ?? 12.r;
    final Size buttonSize = Size(width ?? Get.width, height ?? 53.h);
    final Widget buttonChild = loading
        ? SizedBox(
            height: 20.h,
            width: 20.h,
            child: const CircularProgressIndicator(color: Colors.white),
          )
        : suffixIcon == null
        ? Text(
            text,
            style:
                textStyle ??
                AppStyles.h3(fontWeight: FontWeight.w500, color: Colors.white),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style:
                    textStyle ??
                    AppStyles.h3(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
              SizedBox(width: iconSpacing),
              suffixIcon!,
            ],
          );

    return Padding(
      padding: margin,
      child: Opacity(
        opacity: isInteractive ? 1 : 0.6,
        child: gradient == null
            ? ElevatedButton(
                onPressed: isInteractive ? onTap : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(buttonRadius),
                  ),
                  backgroundColor: color ?? AppColors.primaryColor,
                  disabledBackgroundColor: (color ?? AppColors.primaryColor)
                      .withValues(alpha: 0.8),
                  minimumSize: buttonSize,
                ),
                child: buttonChild,
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
                child: ElevatedButton(
                  onPressed: isInteractive ? onTap : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonRadius),
                    ),
                    minimumSize: buttonSize,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                  ),
                  child: buttonChild,
                ),
              ),
      ),
    );
  }
}
