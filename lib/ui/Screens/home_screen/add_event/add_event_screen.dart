import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/Screens/home_screen/add_event/custom_event_date_or_time.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/event_name_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = "AddEventScreen";

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themProvider = Provider.of<ThemeProvider>(context);
    List<String> eventNames = [
      appLocalization.sport,
      appLocalization.birthday,
      appLocalization.meeting,
      appLocalization.gaming,
      appLocalization.workshop,
      appLocalization.bookclub,
      appLocalization.exhibition,
      appLocalization.holiday,
      appLocalization.eating,
    ];
    List<String> eventImages = [
      AppAssets.sportEventImage,
      AppAssets.birthdayEventImage,
      AppAssets.meetingEventImage,
      AppAssets.gamingEventImage,
      AppAssets.workShopEventImage,
      AppAssets.bookClubEventImage,
      AppAssets.exhibitionEventImage,
      AppAssets.holidayEventImage,
      AppAssets.eatingEventImage,
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColorLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Event",
          style: AppStyles.mediumBlue20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.2,
              width: width * 1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(eventImages[selectIndex]))),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              height: height * 0.05,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventNames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectIndex = index;
                        setState(() {});
                      },
                      child: EventNameWidget(
                          borderColor: AppColors.primaryColorLight,
                          selecBackgroundColor: AppColors.primaryColorLight,
                          selcTextStyle: AppStyles.mediumWhite16,
                          unselcTextStyle: AppStyles.mediumBlue16,
                          selectEvent: selectIndex == index,
                          eventName: eventNames[index]),
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                "Title",
                style: themProvider.themeMode == ThemeMode.light
                    ? AppStyles.mediumBlack16
                    : AppStyles.mediumWhite16,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Event Title",
                  prefixIcon: Image.asset(AppAssets.titleIcon)),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                "Descreption",
                style: themProvider.themeMode == ThemeMode.light
                    ? AppStyles.mediumBlack16
                    : AppStyles.mediumWhite16,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Event Descreption",
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CustomEventDateOrTime(
              iconPath: AppAssets.dateIcon,
              labelText: "Event Date",
              valueText: "Choose Date",
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomEventDateOrTime(
              iconPath: AppAssets.timeIcon,
              labelText: "Event Time",
              valueText: "Choose Time",
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                "Location",
                style: themProvider.themeMode == ThemeMode.light
                    ? AppStyles.mediumBlack16
                    : AppStyles.mediumWhite16,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryColorLight),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Row(
                    children: [
                      Image.asset(AppAssets.locationIcon),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Text(
                        "Event Location",
                        style: AppStyles.mediumBlue16,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColorLight,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            FilledButton(onPressed: () {}, child: Text("Add Event"))
          ],
        ),
      ),
    );
  }
}
