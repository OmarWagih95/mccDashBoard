import 'dart:developer';

import 'package:MCCAdmin/bloc/blocobserver.dart';
import 'package:MCCAdmin/cash/shared_pref.dart';
import 'package:MCCAdmin/cubits/LanguagesCupit.dart';
import 'package:MCCAdmin/cubits/LanguagesCupitStates.dart';
import 'package:MCCAdmin/cubits/auth_cubit.dart';
import 'package:MCCAdmin/cubits/darkModeCubit.dart';
import 'package:MCCAdmin/cubits/home_page_cubit.dart';
import 'package:MCCAdmin/cubits/login_cubit.dart';
import 'package:MCCAdmin/cubits/order_cubit.dart';
import 'package:MCCAdmin/cubits/services_cubit.dart';
import 'package:MCCAdmin/generated/l10n.dart';
import 'package:MCCAdmin/helpers/constants.dart';
import 'package:MCCAdmin/routing/app_router.dart';
import 'package:MCCAdmin/routing/routes.dart';
import 'package:MCCAdmin/theme/appThemes.dart';
import 'package:MCCAdmin/views/navpages/HomePage.dart';
import 'package:MCCAdmin/views/navpages/Mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  IsOnboardingFinished =
      CashHelper.getBool(key: 'IsOnboardingFinished') ?? false;

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LanguagesCubit()..changeLanguages('en'),
      ),
      BlocProvider(
        create: (context) => Dark_lightModeCubit()..darkAndlightMode('light'),
      ),
      BlocProvider<HomePageCubit>(
        create: (context) => HomePageCubit(),
        child: HomePage(),
      ),
    ],
    child: BlocProvider(
      create: (context) => ServicesCubit(),
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocProvider(
            create: (context) => OrderCubit(),
            child: MyApp(
              approuter: Approuter(),
            ),
          ),
        ),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Approuter approuter;

  MyApp({Key? key, required this.approuter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesCubit, LanguagesState>(
        builder: (context, state) {
      if (state is LanguagesSuccessState) {
        log(state.language);
        return BlocBuilder<Dark_lightModeCubit, Dark_lightModeState>(
          builder: (context, mode) {
            return ScreenUtilInit(
              designSize: Size(380, 812), // used for
              minTextAdapt: true, // used for
              child: MaterialApp(
                locale: Locale(state.language),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme:
                    (mode is LightModeState) ? getlightTheme() : getDarkTheme(),
                initialRoute: (!IsOnboardingFinished)
                    ? Routes.selectLanguagePage
                    : Routes.mainPage,
                onGenerateRoute: approuter.generateRoute,
              ),
            );
          },
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
