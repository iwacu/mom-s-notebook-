import 'package:flutter/material.dart';
import 'package:momnotebook/services/wrapper/wrapper.dart';
import 'package:momnotebook/widgets/add_baby/add_baby.dart';
import 'package:momnotebook/widgets/add_baby/add_baby_form.dart';
import 'package:momnotebook/widgets/add_baby/add_new_baby.dart';
import 'package:momnotebook/widgets/add_baby/update_baby.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_feed/UD_breast_feed/update_breasr_feed.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_feed/breast_feed_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_pumping/UD_update/update_breast_pumping.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_pumping/breast_pumping_page.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/diaper/UD_diaper/update_delete_diaper.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/diaper/diaper_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/feeder/UD_feeder/update_delete_feeder.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/feeder/feeder_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/food/UD_food/update_delete_food.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/food/food_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/sleeping/UD_sleep/update_delete_sleep.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/sleeping/sleep_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/walking/UD_walking/update_delete_walking.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/walking/home_walking.dart';
import 'package:momnotebook/widgets/dashboard/home_dashboard.dart';
import 'package:momnotebook/widgets/pageNotFound/pageNotFound.dart';
import 'package:momnotebook/widgets/splashScreen/auth_content/sign_up/signUpPage.dart';
import 'package:momnotebook/widgets/splashScreen/splashScreen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/add_baby':
        return MaterialPageRoute(builder: (_) => AddBaby());
      case '/add_new_baby':
        return MaterialPageRoute(builder: (_) => AddNewBabyForm());
      case '/add_baby_form':
        return MaterialPageRoute(builder: (_) => AddBabyForm());
      case '/home_dashboard':
        return MaterialPageRoute(
            builder: (_) => HomeDashboard(
                // baby: (arguments as Map)['baby'],
                ));
      case '/feeder':
        return MaterialPageRoute(
            builder: (_) => HomeFeeder(baby: (arguments as Map)['baby']));
      case '/breast_pumping':
        return MaterialPageRoute(
            builder: (_) =>
                HomeBreastPumping(baby: (arguments as Map)['baby']));
      case '/food':
        return MaterialPageRoute(
            builder: (_) => HomeFood(baby: (arguments as Map)['baby']));
      case '/breast_feed':
        return MaterialPageRoute(
            builder: (_) => HomeBreastFeed(baby: (arguments as Map)['baby']));
      case '/sleep':
        return MaterialPageRoute(
            builder: (_) => HomeSleep(baby: (arguments as Map)['baby']));
      case '/walk':
        return MaterialPageRoute(
            builder: (_) => HomeWalking(baby: (arguments as Map)['baby']));
      case '/diaper':
        return MaterialPageRoute(
            builder: (_) => HomeDiaper(baby: (arguments as Map)['baby']));
      case '/diaper_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateDeleteDiaper(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/breast_feed_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateBreastFeed(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/breast_pump_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateBreastPumping(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/feeder_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateFeeder(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/food_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateFood(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/sleep_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateSleep(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/walk_update':
        return MaterialPageRoute(
            builder: (_) => HomeUpdateWalking(
                babyTask: (arguments as Map)['baby_task'],
                baby: (arguments)['baby']));
      case '/baby_update':
        return MaterialPageRoute(
            builder: (_) => UpdateBabyForm(baby: (arguments as Map)['baby']));
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}
