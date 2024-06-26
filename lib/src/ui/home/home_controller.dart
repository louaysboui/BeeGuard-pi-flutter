import 'package:flutter_formation/src/model/current_weather_data.dart';
import 'package:flutter_formation/src/model/five_days_data.dart';
import 'package:flutter_formation/src/service/weather_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  HomeController({required this.city});

  @override
  void onInit() {
    initState();
    getTopFiveCities();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherService(city: '$city').getCurrentWeatherData(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) => {
              print(error),
              update(),
            });
  }

  void getTopFiveCities() {
    List<String> cities = [
      'Bizerte',
      'Tunis',
      'Gabes',
      'sousse',
      'Ariana',
      'Gafsa'
    ];
    for (var c in cities) {
      WeatherService(city: c).getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    }
  }

  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
        onSuccess: (data) {
      fiveDaysData = data;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }
}
