import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "forgetPassword";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.15),
          child: Text(
            appLocalization.forget_password,
            style: TextStyle(fontSize: 22, color: AppColors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          children: [
            Image.asset(AppAssets.forget_password_image),
            SizedBox(
              height: height * 0.02,
            ),
            FilledButton(
                onPressed: () {}, child: Text(appLocalization.reset_password))
          ],
        ),
      ),
    );
  }
}
