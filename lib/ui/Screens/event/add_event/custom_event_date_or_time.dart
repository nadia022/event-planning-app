import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CustomEventDateOrTime extends StatelessWidget {
  String iconPath;
  String labelText;
  String valueText;
  Function DateOrTimeOntap;

  CustomEventDateOrTime(
      {super.key,
      required this.iconPath,
      required this.labelText,
      required this.valueText,
      required this.DateOrTimeOntap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var themProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        Image.asset(iconPath),
        SizedBox(
          width: width * 0.03,
        ),
        Text(
          labelText,
          style: themProvider.themeMode == ThemeMode.light
              ? AppStyles.mediumBlack16
              : AppStyles.mediumWhite16,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            DateOrTimeOntap();
          },
          child: Text(
            valueText,
            style: AppStyles.mediumBlue16,
          ),
        ),
      ],
    );
  }
}
