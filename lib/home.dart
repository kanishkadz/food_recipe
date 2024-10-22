import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();


  getRecipe(String query) async{
    String url = "https://api.edamam.com/search?q=$query&app_id=c90bf8d1&app_key=aca1f0d547799ccb805d117c94b040f0";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(response.body);
    log(data.toString());

    data["hits"].forEach((element){
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Laddoo");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color(0xff213A50), Color(0xff071938)]
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
            children: [
              //Search Bar
              SafeArea(
                child: Container(
                  //Search Wala Container

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == "")
                          {
                            print("Blank search");
                          }else{
                            getRecipe(searchController.text);
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Let's Cook Something!"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("WHAT DO YOU WANT TO COOK TODAY?", style: TextStyle(fontSize: 33, color: Colors.white),),
                    SizedBox(height: 10,),
                    Text("Let's Cook Something New!", style: TextStyle(fontSize: 20,color: Colors.white),)
                  ],
                ),
              ),
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){},
                    child: Card(
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 0.0,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                                recipeList[index].appimgUrl
                                fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          Positioned(
                            left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                  ),
                                  Text(recipeList[0].applabel, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),),
                              ),
                          ),
                          Positioned(
                            right: 0,
                            width: 100,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )
                              ),
                              Text(recipeList[0].appcalories.toString().substring(0, 6)),
                            )
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}
