class RecipeModel {
  String? applabel;
  String? appimgUrl;
  double appcalories;
  String? appurl;

  RecipeModel({
    this.applabel,
    required this.appcalories,
    this.appimgUrl,
    this.appurl,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> recipe) {
    return RecipeModel(
      applabel: recipe["label"] as String?,
      appcalories: recipe["calories"] as double,
      appimgUrl: recipe["image"] as String?,
      appurl: recipe["url"] as String?,
    );
  }
}
