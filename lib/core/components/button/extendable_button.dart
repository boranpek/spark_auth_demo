import 'package:spark_auth_demo/core/constants/ui/ui_constants.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ExtendableButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Function? onPress;
  final Color? borderColor;
  final double? borderWidth;
  final bool isDisabled;
  final double? width;

  const ExtendableButton({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.onPress,
    this.borderColor,
    this.borderWidth,
    this.isDisabled = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: UiConstants.primaryBorderRadius,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shadowColor: Colors.transparent,
          side: BorderSide(
            width: borderWidth ?? 0.0,
            color: borderColor ?? Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: UiConstants.primaryBorderRadius,
          ),
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: isDisabled ? null : onPress as void Function()?,
        child: Text(
          text,
          style: context.textTheme.bodyText1!.copyWith(
            color: context.appColors.white,
          ),
        ),
      ),
    );
  }
}
