import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/locale_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_Provider.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/user/language_bottom_sheet.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/user/theme_bottom_sheet.dart';
import 'package:evently_app/ui/auth/login_screen/login_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var appLocalization = AppLocalizations.of(context)!;
    var localeProvider = Provider.of<LocaleProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 1,
            height: height * 0.25,
            decoration: BoxDecoration(
                color: AppColors.primaryColorLight,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(64))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.07,
                      left: width * 0.04,
                      right: width * 0.04),
                  width: width * 0.35,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(1000),
                          bottomLeft: Radius.circular(1000),
                          bottomRight: Radius.circular(1000)),
                      color: AppColors.white,
                      image: DecorationImage(
                          image: AssetImage(AppAssets.birthdayEventImage),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.055),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userProvider.currentUser!.name,
                        style: AppStyles.largeWhiteBold20,
                      ),
                      SizedBox(
                        height: height * 0.012,
                      ),
                      Text(
                        userProvider.currentUser!.email,
                        style: AppStyles.mediumWhite16,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.025,
                left: width * 0.042,
                bottom: height * 0.02,
                right: width * 0.042),
            child: Text(
              appLocalization.language,
              style: themeProvider.themeMode == ThemeMode.light
                  ? AppStyles.largeBlackBold20
                  : AppStyles.largeWhiteBold20,
            ),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet(context);
            },
            child: Container(
              margin:
                  EdgeInsets.only(left: width * 0.042, right: width * 0.042),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width * 0.9,
              height: height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primaryColorLight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localeProvider.appLocale == "en"
                        ? appLocalization.english
                        : appLocalization.arabic,
                    style: AppStyles.largeBlueBold20,
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.primaryColorLight,
                    size: 55,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.025,
                left: width * 0.042,
                bottom: height * 0.02,
                right: width * 0.042),
            child: Text(
              appLocalization.theme,
              style: themeProvider.themeMode == ThemeMode.light
                  ? AppStyles.largeBlackBold20
                  : AppStyles.largeWhiteBold20,
            ),
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet(
                context,
              );
            },
            child: Container(
              margin:
                  EdgeInsets.only(left: width * 0.042, right: width * 0.042),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width * 0.9,
              height: height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primaryColorLight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    themeProvider.themeMode == ThemeMode.light
                        ? appLocalization.light
                        : appLocalization.dark,
                    style: AppStyles.largeBlueBold20,
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.primaryColorLight,
                    size: 55,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.033, horizontal: width * 0.042),
            child: FilledButton(
                onPressed: () {
                  eventListProvider.filteredList = [];
                  eventListProvider.favoriteEventList = [];
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.babyRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.white,
                      size: 21,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Logout",
                      style: AppStyles.mediumWhite16,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet();
      },
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ThemeBottomSheet();
        });
  }
}
