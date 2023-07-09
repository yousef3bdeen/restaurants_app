import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurants_app/presentation/resources/assets_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(JsonAssets.comingSoon),
    );
  }
}
