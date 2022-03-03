import 'package:momnotebook/constants/colors.dart';

class DataObj {
  List<Map<String, dynamic>> splashData = [
    {
      "title": "Sleeping",
      "image": "assets/icons/sleeping.svg",
      "color": greenGray
    },
    {"title": "Feeder", "image": "assets/icons/feeder.svg", "color": movGray},
    {
      "title": "Breast \nPumping",
      "image": "assets/icons/breast-pumping.svg",
      "color": orGray
    },
    {
      "title": "Breast \nFeed",
      "image": "assets/icons/breast-feed.svg",
      "color": rsGray
    },
    {"title": "Food", "image": "assets/icons/food.svg", "color": buttonBGColor},
    {
      "title": "Diaper",
      "image": "assets/icons/diaper.svg",
      "color": greenAccGray
    },
    {
      "title": "Walking",
      "image": "assets/icons/walking.svg",
      "color": jnAccGray
    }
  ];
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
