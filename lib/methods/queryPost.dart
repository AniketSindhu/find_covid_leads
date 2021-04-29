import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> queryPost(String location, String resouce) {
  print(resouce);
  if (location == 'All' && resouce == 'All') {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots();
  } else if (location == 'All' && resouce != 'All') {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('resources', arrayContains: '$resouce')
        .snapshots();
  } else if (location != 'All' && resouce == 'All') {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('location', isEqualTo: location.toLowerCase())
        .snapshots();
  } else {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .where('resources', arrayContains: '$resouce')
        .where('location', isEqualTo: location.toLowerCase())
        .snapshots();
  }
}
