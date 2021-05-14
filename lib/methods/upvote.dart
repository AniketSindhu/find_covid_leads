import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_covid_leads/models/post.dart';

upvote(int count, Post post) async {
  final x = await FirebaseFirestore.instance
      .collection('posts')
      .where('time', isEqualTo: post.time)
      .get();

  await FirebaseFirestore.instance
      .collection('posts')
      .doc(x.docs[0].id)
      .update({'upvotes': FieldValue.increment(count)});
}

downvote(int count, Post post) async {
  final x = await FirebaseFirestore.instance
      .collection('posts')
      .where('time', isEqualTo: post.time)
      .get();

  await FirebaseFirestore.instance
      .collection('posts')
      .doc(x.docs[0].id)
      .update({'upvotes': FieldValue.increment(-count)});
}
