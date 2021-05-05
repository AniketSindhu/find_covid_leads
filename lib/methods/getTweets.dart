import 'dart:convert';
import 'package:find_covid_leads/models/tweet.dart';
import 'package:http/http.dart' as http;

getTweets(String location, String resource) async {
  //var client = http.Client();
  String query =
      'https://api.covid.army/api/tweets/${location[0].toUpperCase() + location.substring(1, location.length).toLowerCase()}/${resource.toLowerCase()}';
  var url = Uri.parse(query);
  print(url);
  final result = await http.get(url, headers: {});

  if (result.statusCode == 200) {
    print(result.body);
    var list = jsonDecode(result.body);
    return list.map((e) => Tweet.fromJson(e)).toList();
  } else {
    print(result.body);
    throw Exception('Failed to load album');
  }
}
