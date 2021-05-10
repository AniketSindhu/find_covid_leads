class Post {
  String description;
  String location;
  List resources;
  String postedBy;
  DateTime time;
  int upvotes;
  String image;
  Post(
      {this.description,
      this.location,
      this.postedBy,
      this.resources,
      this.time,
      this.upvotes,
      this.image});

  factory Post.fromDocument(Map<String, dynamic> doc) {
    return Post(
      description: doc['description'],
      image: doc['image'],
      location: doc['location'],
      postedBy: doc['postedBy'],
      resources: doc['resources'],
      time: doc['time'].toDate(),
      upvotes: doc['upvotes'],
    );
  }
}
