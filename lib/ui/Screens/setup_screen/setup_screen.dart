import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app/ui/Screens/onboarding_screen/onboarding_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_images.dart';
import 'package:evently_app/providers/locale_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/widgets/language_switch.dart';
import 'package:evently_app/ui/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = "setupScreen";

  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
                top: height * 0.03,
                bottom: height * 0.01,
                left: width * 0.05,
                right: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImages.eventlyHorizentalLogo,
                  height: height * 0.08,
                ),
                Expanded(
                    child: Image.asset(themProvider.themeMode == ThemeMode.dark
                        ? AppImages.setupDarkModeImage
                        : AppImages.setupLightModeImage)),
                Text(
                  AppLocalizations.of(context)!.personalize_your_experience,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.03, bottom: width * 0.03),
                  child: Text(
                    AppLocalizations.of(context)!
                        .choose_your_preferred_theme_and_language_to_get_started_with_a_comfortable_tailored_experience_that_suits_your_style,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    LanguageSwitch(),
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ThemeSwitch(),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.92,
                  height: height * 0.063,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, OnboardingScreen.routeName);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.let_is_start,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
