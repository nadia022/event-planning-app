import 'package:evently_app/providers/locale_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLocalization = AppLocalizations.of(context)!;
    var localeProvider = Provider.of<LocaleProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                localeProvider.appLocale = "en";
              },
              child: localeProvider.appLocale == "en"
                  ? selectedItem(appLocalization.english)
                  : unSelectedItem(appLocalization.english)),
          SizedBox(
            height: height * 0.025,
          ),
          InkWell(
              onTap: () {
                localeProvider.appLocale = "ar";
              },
              child: localeProvider.appLocale == "ar"
                  ? selectedItem(appLocalization.arabic)
                  : unSelectedItem(appLocalization.arabic)),
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
