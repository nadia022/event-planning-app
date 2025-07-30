class Event {
  static const String collectionName = "Events";
  String id;
  String title;
  String descreption;
  DateTime date;
  String time;
  String eventName;
  String eventImage;
  bool isFavorite;

  Event({
    required this.title,
    this.id = '',
    required this.descreption,
    required this.date,
    required this.time,
    required this.eventName,
    required this.eventImage,
    this.isFavorite = false,
  });

  // json to object
  Event.fromFirestore(Map<String, dynamic>? data)
      : this(
            id: data!['id'],
            title: data['title'],
            descreption: data['descreption'],
            date: DateTime.fromMillisecondsSinceEpoch(data['date']),
            time: data['time'],
            eventName: data['eventName'],
            eventImage: data['eventImage'],
            isFavorite: data['isFavorite']);

  //object to json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'descreption': descreption,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'eventName': eventName,
      'eventImage': eventImage,
      'isFavorite': isFavorite
    };
  }
}
