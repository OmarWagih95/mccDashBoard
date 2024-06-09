// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:MCCAdmin/cubits/AppVersionCubit.dart';
import 'package:MCCAdmin/cubits/AppVersionState.dart';
import 'package:MCCAdmin/model/network/appVersion.dart';
import 'package:version/version.dart';
import 'package:MCCAdmin/cash/shared_pref.dart';
import 'package:MCCAdmin/cubits/auth_cubit.dart';
import 'package:MCCAdmin/generated/l10n.dart';
import 'package:MCCAdmin/helpers/constants.dart';
import 'package:MCCAdmin/views/loginScreen.dart';
import 'package:MCCAdmin/views/navpages/MyOrderBeforelogin.dart';
import 'package:MCCAdmin/views/navpages/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bakaatSeyanaa.dart';
import '/views/navpages/HomePage.dart';
import '/views/navpages/MyOrder.dart';
import 'package:upgrader/upgrader.dart';

List<AppVersionModel> initfirebaseversion_ = [];
int Currindx = 0;
int get getCurrindx => Currindx;
void Function() changeremoteindex = () {};

class mainpage extends StatefulWidget {
  final bool? is_login;
  // final int? navigationIndexfromRouting;
  mainpage({
    super.key,
    this.is_login,
    /* this.navigationIndexfromRouting */
  });

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  void changeremoteindexhelper() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    getUserDate() async {
      BlocProvider.of<AuthCubit>(context).user =
          await BlocProvider.of<AuthCubit>(context).getUserData();
    }

    getUserDate();
    ////////////////////////////////////
    getAppVersion_() async {
      BlocProvider.of<AppVersionCubit>(context).getAppVersion();
      log('$initfirebaseversion_');
      print('version is $initfirebaseversion_');
    }

    getAppVersion_();
    initfirebaseversion_ =
        BlocProvider.of<AppVersionCubit>(context).AppVersionDataList;
  }

  Future<bool> _systemBackButtonPressed(BuildContext context) async {
    // if (_navigatorKeys[Currindx].currentState?.canPop() == true) {
    //   _navigatorKeys[Currindx]
    //       .currentState
    //       ?.pop(_navigatorKeys[Currindx].currentContext);
    //   return false;
    // } else {
    // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    String mess1 = S.of(context).exit;
    String mess2 = S.of(context).exit_mess;
    bool? exit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mess1),
        content: Text(mess2),
        actions: [
          TextButton(
              onPressed: () {
                // exit = true;
                Navigator.of(context).pop(true);
              },
              child: Text('نعم')),
          TextButton(
              onPressed: () {
                // exit = false;
                Navigator.of(context).pop(false);
              },
              child: Text('لأ'))
        ],
      ),
    );
    return exit ?? false; // Indicate that the back action is handled
    // }
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    HomePageNavigatorKey,
    LoginScreenNavigatorKey,
    MyOrderBeforeloginKey,
    MypageNavigatorKey,
    SettingsPageNavigatorKey,
    bakaatSeyanaaNavigatorKey,
  ];
  List<Widget> pages = [
    HomePage(),
    MyOrderBeforelogin(),
    SettingsPage(),
    bakaatSeyanaa()
  ];

  List<Widget> pages2 = [HomePage(), Mypage(), SettingsPage(), bakaatSeyanaa()];

  //////////
  @override
  Widget build(BuildContext context) {
    ////////////////////////
    /////////////////////////
    Islogin = CashHelper.getBool(key: 'Islogin') ?? false;
    changeremoteindex = changeremoteindexhelper;
    return BlocBuilder<AppVersionCubit, AppVersionState>(
      builder: (context, state) {
        // log(initfirebaseversion_.first.minVersion);
        var firebaseminAppVersion = '1.0.2';
        // var firebaseminAppVersion = (state is AppVersionGetDataSuccessed &&
        //         initfirebaseversion_.isNotEmpty)
        //     ? initfirebaseversion_.first.minVersion
        //     : version_;

        return WillPopScope(
          onWillPop: () => _systemBackButtonPressed(context),
          child: (compareVersions(firebaseminAppVersion, version_))
              ? UpgradeAlert(
                  showLater: true,
                  showIgnore: true,
                  showReleaseNotes: false,
                  upgrader: Upgrader(
                    // TO DO
                    minAppVersion: firebaseminAppVersion,
                    //****** I should change the app version dynamicly with fire base before 1.0.5 release
                    languageCode: Localizations.localeOf(context).languageCode,
                    debugDisplayAlways: true,
                    // durationUntilAlertAgain: Duration(hours: 1)
                    // debugLogging: true,
                  ),
                  child: Scaffold(
                    bottomNavigationBar: NavigationBar(
                      indicatorShape: StadiumBorder(),
                      animationDuration: Duration(milliseconds: 1000),
                      onDestinationSelected: (int index) {
                        setState(() {
                          Currindx = index;
                        });
                      },
                      selectedIndex: Currindx,
                      destinations: [
                        NavigationDestination(
                          selectedIcon: Card(
                            elevation: 4,
                            child: Icon(
                              size: 40,
                              Icons.apps,
                            ),
                          ),
                          icon: Icon(
                            Icons.apps,
                          ),
                          label: S.of(context).Home,
                        ),
                        NavigationDestination(
                          selectedIcon: Card(
                            elevation: 4,
                            child: Icon(
                              size: 40,
                              Icons.person,
                            ),
                          ),
                          icon: Icon(
                            Icons.person,
                          ),
                          label: S.of(context).My_Order,
                        ),
                        NavigationDestination(
                          selectedIcon: Card(
                            elevation: 4,
                            child: Icon(
                              size: 40,
                              Icons.settings,
                            ),
                          ),
                          icon: Icon(
                            Icons.settings,
                          ),
                          label: S.of(context).Settings,
                        ),
                        NavigationDestination(
                          selectedIcon: Card(
                            elevation: 4,
                            child: Icon(
                              size: 40,
                              Icons.auto_fix_normal,
                            ),
                          ),
                          icon: Icon(
                            Icons.auto_fix_normal,
                          ),
                          label: S.of(context).Maintainance_Packages,
                        ),
                      ],
                    ),
                    body: SafeArea(
                      top: false,
                      child: IndexedStack(
                          index: Currindx,
                          children: (Islogin == false) ? pages : pages2),
                    ),
                  ),
                )
              : Scaffold(
                  bottomNavigationBar: NavigationBar(
                    indicatorShape: StadiumBorder(),
                    animationDuration: Duration(milliseconds: 1000),
                    onDestinationSelected: (int index) {
                      setState(() {
                        Currindx = index;
                      });
                    },
                    selectedIndex: Currindx,
                    destinations: [
                      NavigationDestination(
                        selectedIcon: Card(
                          elevation: 4,
                          child: Icon(
                            size: 40,
                            Icons.apps,
                          ),
                        ),
                        icon: Icon(
                          Icons.apps,
                        ),
                        label: S.of(context).Home,
                      ),
                      NavigationDestination(
                        selectedIcon: Card(
                          elevation: 4,
                          child: Icon(
                            size: 40,
                            Icons.person,
                          ),
                        ),
                        icon: Icon(
                          Icons.person,
                        ),
                        label: S.of(context).My_Order,
                      ),
                      NavigationDestination(
                        selectedIcon: Card(
                          elevation: 4,
                          child: Icon(
                            size: 40,
                            Icons.settings,
                          ),
                        ),
                        icon: Icon(
                          Icons.settings,
                        ),
                        label: S.of(context).Settings,
                      ),
                      NavigationDestination(
                        selectedIcon: Card(
                          elevation: 4,
                          child: Icon(
                            size: 40,
                            Icons.auto_fix_normal,
                          ),
                        ),
                        icon: Icon(
                          Icons.auto_fix_normal,
                        ),
                        label: S.of(context).Maintainance_Packages,
                      ),
                    ],
                  ),
                  body: SafeArea(
                    top: false,
                    child: IndexedStack(
                        index: Currindx,
                        children: (Islogin == false) ? pages : pages2),
                  ),
                ),
        );
      },
    );
  }
}
