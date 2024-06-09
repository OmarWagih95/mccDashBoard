import 'dart:developer';
import 'package:MCCAdmin/cash/shared_pref.dart';
import 'package:MCCAdmin/constants/colors.dart';
import 'package:MCCAdmin/cubits/LanguagesCupit.dart';
import 'package:MCCAdmin/cubits/SearchCupit.dart';
import 'package:MCCAdmin/cubits/auth_cubit.dart';
import 'package:MCCAdmin/cubits/darkModeCubit.dart';
import 'package:MCCAdmin/cubits/login_cubit.dart';
import 'package:MCCAdmin/generated/l10n.dart';
import 'package:MCCAdmin/helpers/constants.dart';
import 'package:MCCAdmin/model/category.dart';
import 'package:MCCAdmin/routing/app_router.dart';
import 'package:MCCAdmin/routing/routes.dart';
import 'package:MCCAdmin/views/navpages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void cashlanguage(String lan) async {
  // to do
  language = lan;
  await CashHelper.setData(
    key: 'language',
    value: language,
  );
}

void cashbrightness(String mod) async {
  // to do
  brightness = mod;
  await CashHelper.setData(
    key: 'brightness',
    value: brightness,
  );
}

class searchbar extends StatelessWidget {
  final List<Categoryy> DUMMY_CATEGORIES;

  final TextEditingController search_controller;

  searchbar({
    super.key,
    required this.search_controller,
    required this.DUMMY_CATEGORIES,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        style: Theme.of(context).textTheme.displaySmall,
        onChanged: (query) => BlocProvider.of<SearchCubit>(context)
            .filterList(query, DUMMY_CATEGORIES),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          enabled: true,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          suffixIcon: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
              )),
          hintText: S.of(context).Search_for_service_or_product,
        ),
        controller: search_controller,
      ),
    );
  }
}

////////////////////////
class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCubitSignOutSuccess) {
          BlocProvider.of<AuthCubit>(context).user = null;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => mainpage(),
              ));
        }
      },
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(50.w, 50.h),
                          bottomLeft: Radius.elliptical(50.w, 50.h)),
                      child: Container(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(150)
                            ),
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          width: 130.w,
                          height: 130.h,
                          'img/mmcassits/logo.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: Text(S.of(context).Home, style: TextStyle()),
                onTap: () {
                  if (curRoute == Routes.mainPage && Currindx != 0) {
                    Currindx = 0;
                    changeremoteindex();
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: Text(S.of(context).Settings, style: TextStyle()),
                onTap: () {
                  Currindx = 2;
                  changeremoteindex();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_home_work,
                ),
                title: Text(S.of(context).My_Order, style: TextStyle()),
                onTap: () {
                  Currindx = 1;
                  changeremoteindex();
                  // debugPrint(
                  //     '${BlocProvider.of<AuthCubit>(context).user!.userID!} hna zorar');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BlocProvider(
                  //               create: (context) => OrderCubit()
                  //                 ..GetMyOrders(
                  //                     BlocProvider.of<AuthCubit>(context)
                  //                         .user!
                  //                         .userID!),
                  //               child: MyOrdersScreen(),
                  //             )));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: Text(S.of(context).Sign_out, style: TextStyle()),
                onTap: () async {
                  authCubit.signOut();
                  await CashHelper.setData(
                    key: 'Islogin',
                    value: false,
                  );
                  BlocProvider.of<LoginCubit>(context).emitInitialloginstate();
                },
              ),
              ListTile(
                leading: const Icon(Icons.change_circle),
                title:
                    Text(S.of(context).Language_Exchange, style: TextStyle()),
                onTap: () async {
                  String lan_ =
                      ((Localizations.localeOf(context).languageCode) == 'en')
                          ? 'ar'
                          : 'en';
                  BlocProvider.of<LanguagesCubit>(context)
                      .changeLanguages(lan_);
                  cashlanguage(lan_);
                },
              ),
              SwitchListTile(
                value: BlocProvider.of<Dark_lightModeCubit>(context).mode ==
                        'light'
                    ? true
                    : false,
                onChanged: (value) {
                  BlocProvider.of<Dark_lightModeCubit>(context)
                      .darkAndlightMode(value == false ? 'dark' : 'light');
                  cashbrightness(
                      BlocProvider.of<Dark_lightModeCubit>(context).mode);
                  // CashHelper.setData(
                  //     key: 'brigtness',
                  //     value:
                  //         (BlocProvider.of<Dark_lightModeCubit>(context).mode));
                },
                title:
                    Text(S.of(context).Brightness_change, style: TextStyle()),
                activeColor: Colors.black12,
                hoverColor: Theme.of(context).scaffoldBackgroundColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: FxColors.primary,
              )
            ],
          ),
        );
      },
    );
  }
}
