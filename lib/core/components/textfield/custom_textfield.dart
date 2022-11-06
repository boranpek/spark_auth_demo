import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/constants/ui/ui_constants.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    this.isCapitalized = false,
    this.isObscure = false,
    this.toggleIsObscure,
    this.controller,
    this.focusNode,
  }) : super(key: key);
  final String title;
  final bool isCapitalized;
  final bool? isObscure;
  final void Function()? toggleIsObscure;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureChanged = false;

  @override
  void initState() {
    isObscureChanged = widget.isObscure!;
    widget.controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        cursorColor: context.appColors.primaryColor,
        cursorWidth: 1,
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isObscureChanged,
        autocorrect: false,
        style: context.textTheme.bodyText1,
        textCapitalization: widget.isCapitalized
            ? TextCapitalization.words
            : TextCapitalization.none,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          hintText: widget.title,
          hintStyle: context.textTheme.bodyText1,
          filled: true,
          fillColor: context.appColors.white,
          border: buildOutlineBorder(),
          enabledBorder: buildOutlineBorder(),
          focusedBorder:
              buildOutlineBorder(borderColor: context.appColors.primaryColor),
          suffixIcon: (widget.isObscure! &&
                  (widget.controller?.text.isNotEmpty ?? false))
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureChanged = !isObscureChanged;
                    });
                  },
                  child: Icon(
                    isObscureChanged ? Icons.visibility : Icons.visibility_off,
                    color: context.appColors.textColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineBorder({Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: UiConstants.primaryBorderRadius,
      borderSide: BorderSide(
        width: 1,
        color: borderColor ?? context.appColors.borderColor,
      ),
    );
  }
}
