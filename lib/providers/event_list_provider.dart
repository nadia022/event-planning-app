import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filteredList = [];
  List<String> eventNames = [];
  List<Event> favoriteEventList = [];
  int selectIndex = 0;

  void getEventNames(BuildContext context) {
    eventNames = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    eventList
        .sort((event1, event2) => event1.date.day.compareTo(event2.date.day));
    filteredList = eventList;
    notifyListeners();
  }

  void getFilteredEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredList = eventList.where((event) {
      return event.eventName == eventNames[selectIndex];
    }).toList();

    filteredList
        .sort((event1, event2) => event1.date.day.compareTo(event2.date.day));

    notifyListeners();
  }

  void updateIsFavoriteEvent(Event event, BuildContext context) {
    FirebaseUtils.getEventCollection()
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite}).timeout(
      Duration(milliseconds: 500),
      onTimeout: () {
        print("updated succefully");
      },
    );
    selectIndex == 0 ? getAllEvents() : getFilteredEvents();
    getFavouriteEvents();
  }

  void changeIndex(int newIndex) {
    selectIndex = newIndex;
    if (selectIndex == 0) {
      getAllEvents();
    } else {
      getFilteredEvents();
    }
  }

  void getFavouriteEvents() async {
    var querySnapshot = await FirebaseUtils.getEventCollection()
        .orderBy('date', descending: false)
        .where('isFavorite', isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    notifyListeners();
  }
}
