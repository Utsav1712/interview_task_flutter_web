class GameModel {
  int? gameId;
  String? name;
  String? urlThumb;
  String? groupname;
  String? category;
  String? product;
  String? gamecategory;
  double? minAmount;
  double? maxAmount;

  GameModel({
    this.gameId,
    this.name,
    this.urlThumb,
    this.groupname,
    this.category,
    this.product,
    this.gamecategory,
    this.minAmount,
    this.maxAmount,
  });

  GameModel.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    name = json['name'];
    urlThumb = json['url_thumb'];
    groupname = json['groupname'];
    category = json['category'];
    product = json['product'];
    gamecategory = json['gamecategory'];
    minAmount = json['MinAmount']?.toDouble();
    maxAmount = json['MaxAmount']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['name'] = name;
    data['url_thumb'] = urlThumb;
    data['groupname'] = groupname;
    data['category'] = category;
    data['product'] = product;
    data['gamecategory'] = gamecategory;
    data['MinAmount'] = minAmount;
    data['MaxAmount'] = maxAmount;
    return data;
  }
}
