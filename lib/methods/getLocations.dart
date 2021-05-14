import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<dynamic>> getLocations() async {
  final x = await FirebaseFirestore.instance
      .collection('locations')
      .doc('locations')
      .get();

  return x.data()['loc'];
}
