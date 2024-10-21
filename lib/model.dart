class RecipeModel{
  String applabel;
  String appimgUrl;
  double appcalories;
  String appurl;

  RecipeModel({this.applabel,required this.appcalories, this.appimgUrl, this.appurl});
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimgUrl: recipe["image"],
      appurl: recipe["url"]
    );
  }
}