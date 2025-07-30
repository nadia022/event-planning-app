import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  static Future<void> addEvent(Event event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
