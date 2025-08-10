class MyUser {
  static const String collectionName = "Users";
  String id;
  String name;
  String email;
  MyUser({required this.email, required this.name, required this.id});

  //object => json
  Map<String, dynamic> toFireStore() {
    return {'name': name, 'email': email, 'id': id};
  }

  // json => object
  MyUser.fromFirestore(Map<String, dynamic>? data)
      : this(email: data!['email'], name: data['name'], id: data['id']);
}
