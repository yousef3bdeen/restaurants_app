import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurants_app/app/app_prefs.dart';
import 'package:restaurants_app/app/constants.dart';
import 'package:restaurants_app/app/dependency_injection.dart';
import 'package:restaurants_app/presentation/resources/routes_manager.dart';
import 'package:restaurants_app/presentation/resources/styles_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then(
          (isUserLoggedIn) => {
            if (isUserLoggedIn)
              {Navigator.pushReplacementNamed(context, Routes.mainRoute)}
            else
              {
                _appPreferences.isOnBoardeingViewed().then(
                      (isOnBoardeingViewed) => {
                        if (isOnBoardeingViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      },
                    ),
              },
          },
        );

    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      // body: Center(child: SvgPicture.asset(ImageAssets.splashLogo)),
      body: Center(
          child: IconApp()),
    );
  }

  @override
  void despose() {
    _timer?.cancel();
    super.dispose();
  }
}

class IconApp extends StatelessWidget {
  const IconApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    const Icon(Icons.restaurant, size: Constants.sizeIconSplash),
    Text('RESTAURANTS APP',
        style: getBoldStyle(
            color: ColorManager.black,
            fontSize: Constants.sizeTextSplash))
        ],
      );
  }
}
