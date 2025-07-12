import 'package:evently_app/ui/Screens/home_screen/home_screen.dart';
import 'package:evently_app/auth/forget_password_screen/forget_password_screen.dart';
import 'package:evently_app/auth/login_screen/login_screen.dart';
import 'package:evently_app/ui/Screens/onboarding_screen/onboarding_screen.dart';
import 'package:evently_app/auth/register_screen/register_screen.dart';
import 'package:evently_app/ui/Screens/setup_screen/setup_screen.dart';
import 'package:evently_app/ui/Screens/splash_screen.dart';
import 'package:evently_app/Theme/app_theme.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/locale_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LocaleProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themProvider = Provider.of<ThemeProvider>(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        SetupScreen.routeName: (_) => SetupScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeProvider.appLocale),
    );
  }
}
