import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch.rolling(
      onChanged: (value) {
        themeProvider.themeMode = value;
        setState(() {});
      },
      style: ToggleStyle(
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
          indicatorBorder: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          )),
      current: themeProvider.themeMode,
      values: [ThemeMode.light, ThemeMode.dark],
      iconBuilder: (value, foreground) {
        if (value == ThemeMode.light) {
          return Icon(Icons.sunny, color: AppColors.offWhite);
        } else {
          return Icon(
            Icons.nightlight,
            color: themeProvider.themeMode == ThemeMode.light
                ? Theme.of(context).primaryColor
                : AppColors.offWhite,
          );
        }
      },
    );
  }
}
