import 'dart:developer';

import 'package:MCC/cash/shared_pref.dart';
import 'package:MCC/constants/colors.dart';
import 'package:MCC/cubits/LanguagesCupit.dart';
import 'package:MCC/cubits/SearchCupit.dart';
import 'package:MCC/cubits/SearchCupitStates.dart';
import 'package:MCC/cubits/auth_cubit.dart';
import 'package:MCC/cubits/auth_cubit.dart';
import 'package:MCC/cubits/darkModeCubit.dart';
import 'package:MCC/cubits/home_page_cubit.dart';
import 'package:MCC/cubits/order_cubit.dart';
import 'package:MCC/generated/l10n.dart';
import 'package:MCC/helpers/constants.dart';
import 'package:MCC/model/category.dart';
import 'package:MCC/model/dummyData.dart';
import 'package:MCC/model/userModel.dart';
import 'package:MCC/routing/routes.dart';
import 'package:MCC/views/navpages/HomePage.dart';
import 'package:MCC/views/navpages/main_page.dart';
import 'package:MCC/widgets/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../views/MyOrdersScreen.dart';
import '../views/loginScreen.dart';
import '/cubits/visibilityCubit.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        style: Theme.of(context).textTheme.displaySmall,
        onChanged: (query) => BlocProvider.of<SearchCubit>(context)
            .filterList(query, DUMMY_CATEGORIES),
        textDirection: TextDirection.rtl,

        // decoration: InputDecoration(
        //   hintStyle: TextStyle(color: Theme.of(context).hintColor,fontSize: 14.w),
        //   enabled: true
        // ,enabledBorder: OutlineInputBorder(
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          enabled: true,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          suffixIcon: IconButton(
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

// class leftappbar extends StatefulWidget {
//   leftappbar({super.key});

//   @override
//   State<leftappbar> createState() => _leftappbarState();
// }

// class _leftappbarState extends State<leftappbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         IconButton(
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             icon: const Icon(
//               Icons.menu,
//               // color: ColorsManager.Color10Light,
//             )),
//         IconButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text(
//                 S.of(context).No_notifications_now,
//                 style: TextStyle(fontSize: 32),
//               )));
//             },
//             icon: Icon(
//               Icons.notifications,
//               color: Theme.of(context).iconTheme.color,
//               // color: ColorsManager.Color10Light
//             )),
//       ]),
//     );
//   }
// }

class messageText extends StatelessWidget {
  bool isVisible;

  messageText({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 223, 223, 237),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
                topRight: Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).Text_us_for_any_help_or_question,
              style: const TextStyle(),
            ),
            IconButton(
                onPressed: () {
                  BlocProvider.of<VisibilityCubit>(context).toggleVisibility();
                },
                icon: const Icon(Icons.cancel))
          ],
        ),
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
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'img/mmcassits/logo_12.png',
                          fit: BoxFit.cover,
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
                    if (ModalRoute.of(context)!.settings.name ==
                        Routes.mainPage) {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.mainPage);
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
                    // print(
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
                  },
                ),
                // ListTile(
                //
                //   leading: Switch(value: false, onChanged: (value){
                //     print('changed');
                //   }),
                //   title:
                //       Text(S.of(context).Brightness_change, style: TextStyle()),
                //   onTap: () async {
                //     final mode =
                //         BlocProvider.of<Dark_lightModeCubit>(context).mode;
                //     log(' from onPressed1 mode is $mode');
                //     BlocProvider.of<Dark_lightModeCubit>(context)
                //         .darkAndlightMode(mode == 'light' ? 'dark' : 'light');
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.change_circle),
                  title:
                      Text(S.of(context).Language_Exchange, style: TextStyle()),
                  onTap: () async {
                    BlocProvider.of<LanguagesCubit>(context).changeLanguages(
                        ((Localizations.localeOf(context).languageCode) == 'en')
                            ? 'ar'
                            : 'en');
                  },
                ),
                BlocBuilder<HomePageCubit, HomePageState>(
                  builder: (context, state) {
                    return SwitchListTile(
                      value: BlocProvider.of<HomePageCubit>(context).darkMode,
                      onChanged: (value) {
                        BlocProvider.of<HomePageCubit>(context)
                            .changeSwitch(value);
                        final mode =
                            BlocProvider.of<Dark_lightModeCubit>(context).mode;
                        log(' from onPressed1 mode is $mode');
                        BlocProvider.of<Dark_lightModeCubit>(context)
                            .darkAndlightMode(
                                mode == 'light' ? 'dark' : 'light');
                      },
                      title: Text(S.of(context).Brightness_change,
                          style: TextStyle()),
                      activeColor: Theme.of(context).primaryColor,
                      hoverColor: Theme.of(context).primaryColor,
                      inactiveThumbColor: Colors.black,
                      inactiveTrackColor: Colors.black12,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
