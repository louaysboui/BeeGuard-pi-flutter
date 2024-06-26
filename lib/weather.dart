import 'package:flutter/material.dart';
import 'package:flutter_formation/src/ui/home/home_binding.dart';
import 'package:flutter_formation/src/ui/home/home_weather.dart';
import 'package:get/get.dart';

class MyWeather extends StatelessWidget {
  const MyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        )
      ],
    );
  }
}
