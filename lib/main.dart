import 'dart:developer';
import 'package:MCCAdmin/bloc/blocobserver.dart';
import 'package:MCCAdmin/cash/shared_pref.dart';
import 'package:MCCAdmin/cubits/AppVersionCubit.dart';
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
import 'package:MCCAdmin/model/network/appVersion.dart';
import 'package:MCCAdmin/routing/app_router.dart';
import 'package:MCCAdmin/routing/routes.dart';
import 'package:MCCAdmin/theme/appThemes.dart';
import 'package:MCCAdmin/views/navpages/HomePage.dart';
import 'package:MCCAdmin/views/navpages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /////////////// only for testing
  await Upgrader.clearSavedSettings();
  ///////////////
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  version_ = packageInfo.version;

  IsOnboardingFinished =
      CashHelper.getBool(key: 'IsOnboardingFinished') ?? false;

  language = CashHelper.getString(key: 'language');

  brightness = CashHelper.getString(key: 'brightness');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguagesCubit()..changeLanguages('ar'),
        ),
        BlocProvider(
          create: (context) => Dark_lightModeCubit()..darkAndlightMode('light'),
        ),
        BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit()..getCategoriesData(),
          child: HomePage(),
        ),
        BlocProvider<AppVersionCubit>(
          create: (context) => AppVersionCubit()..getAppVersion(),
          child: mainpage(),
        ),
      ],
      child: BlocProvider(
        create: (context) => ServicesCubit(),
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocProvider(
            create: (context) => AuthCubit() /* ..getUserData() */,
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
  });
}

class MyApp extends StatelessWidget {
  final Approuter approuter;

  MyApp({Key? key, required this.approuter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getUserDate() async {
      BlocProvider.of<AuthCubit>(context).user =
          await BlocProvider.of<AuthCubit>(context).getUserData();
    }

    getUserDate();
    ////////////
    return BlocBuilder<LanguagesCubit, LanguagesState>(
        builder: (context, state) {
      if (state is LanguagesSuccessState) {
        log(state.language);
        return BlocBuilder<Dark_lightModeCubit, Dark_lightModeState>(
          builder: (context, mode) {
            return ScreenUtilInit(
              designSize: const Size(380, 812), // used for
              minTextAdapt: true, // used for
              child: MaterialApp(
                locale: (language == null)
                    ? Locale(state.language)
                    : Locale(language!),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                // check if first time to run app (no cash) take the initial value of the state
                theme: (brightness == null)
                    ? (mode is LightModeState)
                        ? getlightTheme()
                        : getDarkTheme()
                    : (brightness == 'light')
                        ? getlightTheme()
                        : getDarkTheme(),
                initialRoute: (!IsOnboardingFinished!)
                    ? Routes.selectLanguagePage
                    : Routes.mainPage,
                onGenerateRoute: approuter.generateRoute,
              ),
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
