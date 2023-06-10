import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key, this.onChange}) : super(key: key);

  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: locator<AppThemeColors>().surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(9.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(9.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            .copyWith(color: locator<AppThemeColors>().grey),
        hintText: 'search'.tr(context),
        prefixIcon: const Icon(CupertinoIcons.search),
      ),
    );
  }
}
