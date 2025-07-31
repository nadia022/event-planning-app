import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/event_item_widget.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/event_name_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventNames = [
      appLocalization.all,
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
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents();
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalization.welcome_back, style: AppStyles.mediumWhite14),
            // return from data base
            Text(
              "User Name ",
              style: AppStyles.largeWhiteBold20,
            ),
            Row(
              children: [
                Image.asset(AppAssets.unSelcLocIcon),
                Text(
                  appLocalization.cairo,
                  style: AppStyles.mediumWhite14,
                ),
                Text(
                  " , ",
                  style: TextStyle(color: AppColors.white),
                ),
                Text(
                  appLocalization.egypt,
                  style: AppStyles.mediumWhite14,
                ),
              ],
            )
          ],
        ),
        actions: [
          Icon(
            Icons.sunny,
            color: AppColors.white,
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            height: height * 0.045,
            width: width * 0.099,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white),
            child: Center(
              child: Text(
                "EN",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: height * 0.008),
            height: height * 0.088,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            ),
            child: DefaultTabController(
              length: eventNames.length,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                isScrollable: true,
                onTap: (value) {
                  eventListProvider.changeIndex(value);
                  setState(() {});
                },
                tabs: eventNames.map((eventName) {
                  return EventNameWidget(
                    selcTextStyle: AppStyles.mediumBlue16,
                    unselcTextStyle: AppStyles.mediumWhite16,
                    selecBackgroundColor: AppColors.white,
                    selectEvent: eventListProvider.selectIndex ==
                        eventNames.indexOf(eventName),
                    eventName: eventName,
                    borderColor: AppColors.white,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: eventListProvider.filteredList.isEmpty
                ? Center(
                    child: Text(
                      "Events not found",
                      style: AppStyles.mediumBlack16,
                    ),
                  )
                : ListView.builder(
                    itemCount: eventListProvider.filteredList.length,
                    itemBuilder: (BuildContext context, int intex) {
                      return EventItemWidget(
                        event: eventListProvider.filteredList[intex],
                      );
                    }),
          )
        ],
      ),
    );
  }
}
