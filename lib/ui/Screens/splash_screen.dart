import 'package:evently_app/ui/Screens/setup_screen/setup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, SetupScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Spacer(),
            Center(
                child: Image.asset("assets/images/evently_vertical_logo.png")),
            Spacer(),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Image.asset("assets/images/route_logo.png"),
            )),
          ],
        ),
      ),
    );
  }
}
