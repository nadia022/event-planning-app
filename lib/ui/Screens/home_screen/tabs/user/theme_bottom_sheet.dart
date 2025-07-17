import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLocalization = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                themeProvider.themeMode = ThemeMode.light;
              },
              child: themeProvider.themeMode == ThemeMode.light
                  ? selectedItem(appLocalization.light)
                  : unSelectedItem(appLocalization.light)),
          SizedBox(
            height: height * 0.025,
          ),
          InkWell(
              onTap: () {
                themeProvider.themeMode = ThemeMode.dark;
              },
              child: themeProvider.themeMode == ThemeMode.dark
                  ? selectedItem(appLocalization.dark)
                  : unSelectedItem(appLocalization.dark)),
        ],
      ),
    );
  }

  Widget selectedItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: AppStyles.largeBlueBold20,
        ),
        Spacer(),
        Icon(
          Icons.check,
          color: AppColors.primaryColorLight,
        )
      ],
    );
  }

  Widget unSelectedItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: AppStyles.largeBlackBold20,
        ),
        Spacer(),
        Icon(
          Icons.check,
          color: AppColors.gray,
        )
      ],
    );
  }
}
