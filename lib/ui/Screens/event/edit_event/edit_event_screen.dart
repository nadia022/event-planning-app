import 'package:evently_app/assets/app_assets.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_Provider.dart';
import 'package:evently_app/ui/Screens/event/add_event/custom_event_date_or_time.dart';
import 'package:evently_app/ui/Screens/home_screen/home_screen.dart';
import 'package:evently_app/ui/Screens/home_screen/tabs/home/event_name_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'editEventScreen';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int selectIndex = 0;
  String eventImage = '';
  String eventName = 'Sport';
  bool flage = false;
  late Event args;

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  String? time;

  TextEditingController titleController = TextEditingController();

  TextEditingController descreptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    @override
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    args = ModalRoute.of(context)!.settings.arguments as Event;

    var themProvider = Provider.of<ThemeProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNames(context);
    eventListProvider.eventNames.removeAt(0);
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
    if (flage == false) {
      selectIndex = eventListProvider.eventNames.indexOf(args.eventName);
    }
    eventImage = eventImages[selectIndex];
    eventName = eventListProvider.eventNames[selectIndex];

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
          "Edit Event",
          style: AppStyles.mediumBlue20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.025),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                          image: AssetImage(
                              flage ? eventImage : args.eventImage))),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventListProvider.eventNames.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            flage = true;
                            selectIndex = index;
                            setState(() {});
                          },
                          child: EventNameWidget(
                              borderColor: AppColors.primaryColorLight,
                              selecBackgroundColor: AppColors.primaryColorLight,
                              selcTextStyle: AppStyles.mediumWhite16,
                              unselcTextStyle: AppStyles.mediumBlue16,
                              selectEvent: selectIndex == index,
                              eventName: eventListProvider.eventNames[index]),
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
                  initialValue: args.title,
                  onSaved: (newValue) {
                    titleController.text = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter event title";
                    }
                    return null;
                  },
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
                  initialValue: args.descreption,
                  // controller: descreptionController,
                  onSaved: (newValue) {
                    descreptionController.text = newValue!;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Event Descreption",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter event descreption";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomEventDateOrTime(
                  iconPath: AppAssets.dateIcon,
                  labelText: "Event Date",
                  valueText: selectedDate == null
                      ? DateFormat('y/MM/dd').format(args.date)
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  DateOrTimeOntap: chooseDate,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomEventDateOrTime(
                  iconPath: AppAssets.timeIcon,
                  labelText: "Event Time",
                  valueText: selectedTime == null ? args.time : time!,
                  DateOrTimeOntap: chooseTime,
                ),
                SizedBox(
                  height: height * 0.012,
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
                  height: height * 0.017,
                ),
                FilledButton(
                    onPressed: () {
                      updateEvent();
                    },
                    child: Text("Update Event"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateEvent() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      DialogUtils.showloading(context: context, message: "Updating Event");
      try {
        Event event = Event(
          title: titleController.text,
          descreption: descreptionController.text,
          date: selectedDate ?? args.date,
          time: time ?? args.time,
          id: args.id,
          eventName: eventName,
          eventImage: eventImage,
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        await FirebaseUtils.updateEvent(event, userProvider.currentUser!.id);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Event Updated successfully",
          posName: "Ok",
          posAction: () {
            eventListProvider.getAllEvents(userProvider.currentUser!.id);
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          },
        );
      } on TimeoutException catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.message ?? "Request timed out. Please try again.",
          posName: "Ok",
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: "Something went wrong. Please try again.",
          posName: "Ok",
        );
      }
    }
  }

  void chooseDate() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate;
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    time = selectedTime!.format(context);
    setState(() {});
  }
}
