import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurants_app/presentation/resources/assets_manager.dart';
import 'package:restaurants_app/presentation/resources/color_manager.dart';
import 'package:restaurants_app/presentation/resources/styles_manager.dart';
import 'package:restaurants_app/presentation/resources/values_manager.dart';

import '../../../../../domain/model/models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Store>? stores;
  List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "KFC", "image": ImageAssets.kfc},
    {"id": 2, "name": "Burger King", "image": ImageAssets.burgerKing},
    {"id": 3, "name": "Pizza hut", "image": ImageAssets.pizzaHut},
    {"id": 4, "name": "McDonald\'s", "image": ImageAssets.mac},
    {"id": 5, "name": "Sub Way", "image": ImageAssets.subWay},
    {"id": 6, "name": "Restaurant 6", "image": ImageAssets.res6},
    {"id": 7, "name": "Restaurant 7", "image": ImageAssets.res7},
    {"id": 8, "name": "Restaurant 8", "image": ImageAssets.res8},
    {"id": 9, "name": "Restaurant 9", "image": ImageAssets.res9},
    {"id": 10, "name": "Restaurant 10", "image": ImageAssets.res10},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
                hintText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundUsers.length,
              itemBuilder: (context, index) => Container(
                key: ValueKey(_foundUsers[index]["id"]),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: [
                    Card(
                      child: Container(
                        width: double.infinity,
                        child: Image.asset(
                          _foundUsers[index]["image"],
                          fit: BoxFit.cover,
                          color:
                              Colors.black.withOpacity(0.25), // جعل الصورة خافتة
                          colorBlendMode: BlendMode.srcOver,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_foundUsers[index]["name"],
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: AppSize.s20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
