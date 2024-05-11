// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:MccAdmin/constants/colors.dart';
import 'package:MccAdmin/cubits/LanguagesCupit.dart';
import 'package:MccAdmin/cubits/SearchCupit.dart';
import 'package:MccAdmin/cubits/SearchCupitStates.dart';
import 'package:MccAdmin/cubits/login_cubit.dart';
import 'package:MccAdmin/cubits/services_cubit.dart';
import 'package:MccAdmin/generated/l10n.dart';
import 'package:MccAdmin/model/category.dart';
import 'package:MccAdmin/model/dummyData.dart';
import 'package:MccAdmin/model/userModel.dart';
import 'package:MccAdmin/services/Network_data_services.dart';
import 'package:MccAdmin/widgets/leftappbarUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/home_page_cubit.dart';
import '../categories_screan.dart';
import '/cubits/visibilityCubit.dart';
import '/widgets/homePageHelperWidgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/visibilityCubitStates.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

GlobalKey<NavigatorState> HomePageNavigatorKey = GlobalKey<NavigatorState>();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    late userModel? user = BlocProvider.of<AuthCubit>(context).user;
    // TODO: implement initState
    // print(BlocProvider.of<AuthCubit>(context).user!.userID!);
    getUserDate() async {
      print('hna1');
      try {
        user = await BlocProvider.of<AuthCubit>(context).getUserData();
        print('${user!.userID!} test main user');
      } catch (e) {
        print(e);
      }
    }

    try {
      getUserDate();
      print('userData tmaaam');
    } catch (e) {
      print(e);
    }
    // BlocProvider.of<HomePageCubit>(context).getCategoriesData();
  }

  var SearchCubitDUMMY_CATEGORIES;
  final search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchCubitDUMMY_CATEGORIES =
        context.read<HomePageCubit>().categoryDataList;
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(create: (BuildContext context) {
          return SearchCubit(SearchCubitDUMMY_CATEGORIES, context);
        }),
        BlocProvider<VisibilityCubit>(
          create: (BuildContext context) => VisibilityCubit(),
        ),
        BlocProvider<ServicesCubit>(
          create: (BuildContext context) => ServicesCubit(),
        ),
      ],
      child: Scaffold(
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
              child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    //app bar
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.h),
                              bottomRight: Radius.circular(25.h))),
                      // height: 160.h,
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: LeftAppBarUpdate()),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Dedicated to perfection,',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .merge(
                                      GoogleFonts.aBeeZee(
                                          // ,fontSize: 20.h
                                          ),
                                    )),
                            Text(
                              'every single time',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .merge(GoogleFonts.aBeeZee()),
                              // GoogleFonts.aboreto(
                              //     color:,
                              //     fontWeight: FontWeight.bold
                              //     ,fontSize: 20.h
                              // ),
                            ),
                            BlocBuilder<SearchCubit, searchState>(
                                builder: (context, state) {
                              return searchbar(
                                DUMMY_CATEGORIES: SearchCubitDUMMY_CATEGORIES,
                                search_controller: search_controller,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    // rest of screen
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.h, vertical: 10.h),
                      child: Column(
                        children: [
                          Align(
                            alignment:
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Text(
                                S.of(context).choose_maintenance_service,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .merge(
                                        GoogleFonts.aBeeZee(fontSize: 17.h))),
                          ),
                          categoriesScreen()
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ))),
    );
  }
}
/////////////*********************************************************//////////////////


