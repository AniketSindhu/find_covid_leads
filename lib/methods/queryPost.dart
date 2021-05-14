import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> queryPost(String location, List<String> resouce) {
  print(resouce);
  if (location == 'All' && resouce.isEmpty) {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots();
  } else if (location == 'All' && resouce.isNotEmpty) {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('resources', arrayContainsAny: resouce)
        .snapshots();
  } else if (location != 'All' && resouce.isEmpty) {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('location', isEqualTo: location.toLowerCase())
        .snapshots();
  } else {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('resources', arrayContainsAny: resouce)
        .where('location', isEqualTo: location.toLowerCase())
        .snapshots();
  }
}
