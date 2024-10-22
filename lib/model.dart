class RecipeModel {
  final String applabel;
  final String appimgUrl;
  final double appcalories;

  RecipeModel({required this.applabel, required this.appimgUrl, required this.appcalories});

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      applabel: map['label'],
      appimgUrl: map['image'],
      appcalories: map['calories'],
    );
  }
}
