import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.008, horizontal: width * 0.016),
      margin: EdgeInsets.symmetric(
          vertical: height * 0.008, horizontal: width * 0.028),
      width: width * 0.1,
      height: height * 0.22,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(event.eventImage), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColorLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.11,
            height: height * 0.064,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.white),
            child: Column(
              children: [
                Text(
                  '${event.date.day}',
                  style: AppStyles.largeBlueBold20,
                ),
                Text(
                  DateFormat('MMM').format(event.date),
                  style: AppStyles.largeBlueBold20,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            width: width * 0.90,
            height: height * 0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.descreption,
                  style: AppStyles.mediumBlackBold14,
                ),
                Icon(
                  Icons.favorite,
                  color: AppColors.primaryColorLight,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
