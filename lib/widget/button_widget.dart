import 'package:flutter/material.dart';
import 'package:storys_apps/utils/style.dart';

class ButtonWidget extends StatelessWidget {
  Color? color;
  double radius;
  double paddingHorizontal;
  double paddingVertical;
  VoidCallback? onTap;
  double width;
  double height;
  Color? borderColor;
  Color? textColor;
  String text;
  FontWeight? fontWeight;
  Widget? leading;
  Widget? trailing;

  ButtonWidget({
    Key? key,
    required this.text,
    required this.radius,
    required this.paddingHorizontal,
    required this.paddingVertical,
    this.onTap,
    this.borderColor,
    this.color,
    this.textColor,
    required this.width,
    required this.height,
    this.fontWeight,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        decoration: BoxDecoration(
            color: color ?? secondaryColor,
            border: Border.all(
              color: borderColor ?? Colors.transparent, // red as border color
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            )),
        child: Row(
          children: [
            if (leading == null) Container() else leading!,
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                  fontWeight: fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (trailing == null) Container() else trailing!,
          ],
        ),
      ),
    );
  }
}
