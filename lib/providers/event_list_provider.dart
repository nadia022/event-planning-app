import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/foundation.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filteredList = [];
  List<String> eventNames = [
    'All',
    'Sport',
    'Birthday',
    'Meeting',
    'Gaming',
    'Workshop',
    'Bookclub',
    'Exhibition',
    'Holiday',
    'Eating',
  ];

  int selectIndex = 0;

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
    filteredList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredList = eventList.where((event) {
      return event.eventName == eventNames[selectIndex];
    }).toList();

    filteredList
        .sort((event1, event2) => event1.date.day.compareTo(event2.date.day));

    notifyListeners();
  }

  void changeIndex(int newIndex) {
    selectIndex = newIndex;
    if (selectIndex == 0) {
      getAllEvents();
    } else {
      getFilteredEvents();
    }
  }
}
