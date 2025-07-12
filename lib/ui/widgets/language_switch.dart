import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app/assets/app_images.dart';
import 'package:evently_app/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSwitch extends StatefulWidget {
  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
    return AnimatedToggleSwitch.rolling(
      onChanged: (value) {
        localeProvider.appLocale = value;
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
      current: localeProvider.appLocale,
      values: ["en", "ar"],
      iconBuilder: (value, foreground) {
        if (value == "en") {
          return CircleAvatar(
            backgroundImage: AssetImage(AppImages.englishIcon),
          );
        } else {
          return CircleAvatar(
            backgroundImage: AssetImage(AppImages.arabicIcon),
          );
        }
      },
    );
  }
}
