import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class GameProvider {
  static const String exclusiveUrl = "https://useruatapi.coinbet91.com/api/GameV1/GetTurnoverGameList";
  static const String categoryUrl = "https://cdn.coinbet91.com/P65/gamelist/allgames_v2.json";

  Future<List<GameModel>> getExclusiveGames({String category = "turnover"}) async {
    final response = await http.get(Uri.parse("$exclusiveUrl?GameCategory=$category&SiteCode=P65"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => GameModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load exclusive games");
    }
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse(categoryUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // Extract unique gamecategory values
      Set<String> categories = {};
      for (var item in body) {
        if (item['gamecategory'] != null) {
          categories.add(item['gamecategory'].toString());
        }
      }
      List<String> sortedCategories = categories.toList()..sort();
      // Add "All" and "turnover" at the beginning
      List<String> finalCategories = ["All"];
      if (!sortedCategories.contains("turnover")) {
        finalCategories.add("turnover");
      }
      finalCategories.addAll(sortedCategories);
      return finalCategories;
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<GameModel>> getCategoryGames() async {
    final response = await http.get(Uri.parse(categoryUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => GameModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load category games");
    }
  }
}
