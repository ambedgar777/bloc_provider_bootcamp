import 'package:bloc_provider_bootcamp/presentation/screens/home_screen.dart';
import 'package:bloc_provider_bootcamp/presentation/screens/second_screen.dart';
import 'package:bloc_provider_bootcamp/presentation/screens/settings_screen.dart';
import 'package:bloc_provider_bootcamp/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(title: 'HomeScreen', color: Colors.blueAccent),
        );
        break;
      case '/second':
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(
              title: 'SecondScreen', color: Colors.redAccent),
        );
        break;
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(
              title: 'ThirdScreen', color: Colors.tealAccent),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(
              title: 'SettingsScreen', color: Colors.yellowAccent),
        );
      default:
        return null;
    }
  }
}
