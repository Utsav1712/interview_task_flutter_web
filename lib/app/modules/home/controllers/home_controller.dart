import 'package:get/get.dart';
import '../../../data/models/game_model.dart';
import '../../../data/providers/game_provider.dart';

class HomeController extends GetxController {
  final GameProvider _gameProvider = GameProvider();

  final exclusiveGames = <GameModel>[].obs;
  final categoryGames = <GameModel>[].obs;
  final isLoading = true.obs;
  final error = "".obs;

  final categories = <String>[].obs;
  final selectedCategory = "".obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    try {
      isLoading.value = true;
      error.value = "";
      
      // 1. Fetch Categories first from allgames_v2.json
      final catList = await _gameProvider.getCategories();
      categories.assignAll(catList);
      
      // 2. Set default category
      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first;
        await fetchGamesForCategory(selectedCategory.value);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGamesForCategory(String category) async {
    try {
      isLoading.value = true;
      error.value = "";
      
      if (category == "All") {
        // Fetch all games from the static JSON
        final results = await _gameProvider.getCategoryGames();
        categoryGames.assignAll(results);
      } else {
        // Fetch only related games for this specific category from the exclusiveUrl API
        final results = await _gameProvider.getExclusiveGames(category: category);
        categoryGames.assignAll(results);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    if (selectedCategory.value == category) return;
    selectedCategory.value = category;
    fetchGamesForCategory(category);
  }
}
