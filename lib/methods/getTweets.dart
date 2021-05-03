import 'dart:convert';
import 'package:find_covid_leads/models/tweet.dart';
import 'package:http/http.dart' as http;

getTweets(String location, List<String> resource) async {
  //var client = http.Client();
  String query;
  if (resource.isEmpty && location != 'All' && location.trim().length != 0) {
    query =
        "https://api.twitter.com/2/tweets/search/recent?max_results=35&tweet.fields=created_at&query=$location (#CovidHelp OR #Covid19IndiaHelp OR #verified OR #CovidIndia OR #CovidResources OR #COVIDEmergency) -required -requires -is:retweet"
            .toString()
            .replaceAll("#", "%20");
  } else if (resource.isNotEmpty && location == 'All') {
    query =
        "https://api.twitter.com/2/tweets/search/recent?max_results=35&tweet.fields=created_at&query=${resource[0]} (#CovidHelp OR #Covid19IndiaHelp OR #verified OR #CovidIndia OR #CovidResources OR #COVIDEmergency) -required -requires -is:retweet"
            .toString()
            .replaceAll("#", "%20");
  } else if (resource.isNotEmpty &&
      location != 'All' &&
      location.trim().length != 0) {
    query =
        "https://api.twitter.com/2/tweets/search/recent?max_results=35&tweet.fields=created_at&query=${resource[0]} $location (#CovidHelp OR #Covid19IndiaHelp OR #verified OR #CovidIndia OR #CovidResources OR #COVIDEmergency) -required -requires -is:retweet"
            .toString()
            .replaceAll("#", "%20");
  } else {
    query =
        "https://api.twitter.com/2/tweets/search/recent?max_results=35&tweet.fields=created_at&query=available #CovidHelp OR #Covid19IndiaHelp OR #verified OR #CovidIndia OR #CovidResources OR #COVIDEmergency -required -requires -is:retweet"
            .toString()
            .replaceAll("#", "%20");
  }

  var url = Uri.parse(query);
  print(url);
  final result = await http.get(url, headers: {
    'Authorization':
        'Bearer AAAAAAAAAAAAAAAAAAAAAK1yPAEAAAAAEHdadmWm9PyuKRjmMFkPnsxVct8%3Dgs6WqOIBxeu4rFWG5g0jTaN0SblQ9rxwguXTHBnwVI9l1V2rli',
  });

  if (result.statusCode == 200) {
    print(result.body);
    var list = jsonDecode(result.body);
    return list["data"].map((e) => Tweet.fromJson(e)).toList();
  } else {
    print(result.body);
    throw Exception('Failed to load album');
  }
}
