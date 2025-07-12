import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventNameWidget extends StatelessWidget {
  bool selectEvent;
  String eventName;
  EventNameWidget({required this.selectEvent, required this.eventName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.016),
      alignment: Alignment.center,
      width: width * 0.3,
      height: height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: AppColors.white,
        ),
        color: selectEvent ? AppColors.white : Colors.transparent,
      ),
      child: Text(
        eventName,
        style: selectEvent ? AppStyles.mediumBlue16 : AppStyles.mediumWhite16,
      ),
    );
  }
}
