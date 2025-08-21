import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_Provider.dart';
import 'package:evently_app/ui/Screens/event/edit_event/edit_event_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'eventDetails';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final Event args = ModalRoute.of(context)!.settings.arguments as Event;
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColorLight,
          ),
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
        title: Text(
          "Event Details",
          style: AppStyles.mediumBlue20,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, EditEventScreen.routeName,
                  arguments: args);
            },
            child: Icon(
              Icons.edit,
              color: AppColors.primaryColorLight,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.023),
            child: InkWell(
              onTap: () async {
                await FirebaseUtils.deleteEvent(
                    args, userProvider.currentUser!.id);
                eventListProvider.getAllEvents(userProvider.currentUser!.id);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.delete,
                color: AppColors.red,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.025),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.2,
                width: width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(args.eventImage))),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Text(
                args.title,
                style: AppStyles.largeBlueBold20,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Container(
                height: height * 0.067,
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
                      Image.asset(AppAssets.calenderIcon),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.005, horizontal: width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy').format(args.date),
                              style: AppStyles.mediumBlue16,
                            ),
                            Text(
                              args.time,
                              style: AppStyles.mediumBlack16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.065,
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
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.35,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColorLight),
                    borderRadius: BorderRadius.circular(16)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                "Description",
                style: AppStyles.mediumBlack16,
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Text(
                args.descreption,
                style: AppStyles.mediumBlack16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
