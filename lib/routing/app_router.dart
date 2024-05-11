import 'package:MccAdmin/cubits/services_cubit.dart';
import 'package:MccAdmin/model/category.dart';
import 'package:MccAdmin/routing/routes.dart';
import 'package:MccAdmin/views/OnbordingPage.dart';
import 'package:MccAdmin/views/Service_detail_screen.dart';
import 'package:MccAdmin/views/categories_screan.dart';
import 'package:MccAdmin/views/categories_services_screans.dart';
import 'package:MccAdmin/views/navpages/crop.dart';
import 'package:MccAdmin/views/servicesScreen.dart';
import 'package:MccAdmin/views/signeupScreen.dart';
import 'package:MccAdmin/views/loginScreen.dart';
import 'package:MccAdmin/views/navpages/HomePage.dart';
import 'package:MccAdmin/views/navpages/SettingsPage.dart';
import 'package:MccAdmin/views/navpages/main_page.dart';
import 'package:MccAdmin/views/selectLanguage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Approuter {
  late Categoryy Categoryy_;
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.selectLanguagePage:
        return MaterialPageRoute(
          builder: (_) => chooseLanguages(true),
        );
      case Routes.onboargingScreen:
        return MaterialPageRoute(
          builder: (_) => onboardingPage(),
        );
      case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case Routes.mainPage:
        return MaterialPageRoute(
          builder: (_) => mainpage(),
        );
      case Routes.categoriesScreen:
        return MaterialPageRoute(
          builder: (_) => categoriesScreen(),
        );
      // case Routes.ServiceDetailScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => ServiceDetailScreen(),
      //   );
      case Routes.settingsPage:
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
        );
      case Routes.LoginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case Routes.signeupScreen:
        return MaterialPageRoute(
          builder: (_) => SigneUpScreen(),
        );
      case Routes.cropScreen:
        return MaterialPageRoute(
          builder: (_) => cropScreen(),
        );
      case Routes.ServicesScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      ServicesCubit()..getServicesData(Categoryy_.id),
                  child: ServicesScreen(),
                )
            // builder: (_) => ServicesScreen(Categoryy_),
            );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
