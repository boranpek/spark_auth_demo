import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:spark_auth_demo/core/extensions/context_extensions.dart';

import '../../constants/ui/ui_constants.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    Key? key,
    required this.items,
    required this.title,
  }) : super(key: key);
  final List<String> items;
  final String title;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: context.textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.expand_more,
        ),
        style: context.textTheme.bodyText1,
        iconSize: 20,
        iconEnabledColor: context.appColors.textColor,
        iconDisabledColor: context.appColors.textColor,
        buttonHeight: 42,
        buttonPadding: const EdgeInsets.only(left: 20, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: UiConstants.primaryBorderRadius,
          border: Border.all(
            color: context.appColors.borderColor,
          ),
          color: context.appColors.white,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: UiConstants.primaryBorderRadius,
          color: context.appColors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius:
            const Radius.circular(UiConstants.primaryBorderRadiusValue),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, 0),
      ),
    );
  }
}
