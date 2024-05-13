import 'package:MCCAdmin/cubits/auth_cubit.dart';
import 'package:MCCAdmin/cubits/services_cubit.dart';
import 'package:MCCAdmin/generated/l10n.dart';
import 'package:MCCAdmin/model/service.dart';
import 'package:MCCAdmin/routing/routes.dart';
import 'package:MCCAdmin/widgets/MyButtonW.dart';
import 'package:MCCAdmin/widgets/Mybutton.dart';
import 'package:MCCAdmin/widgets/OurPropertiesListItem.dart';
import 'package:MCCAdmin/widgets/customAppbar.dart';
import 'package:MCCAdmin/widgets/homePageHelperWidgets.dart';
import 'package:MCCAdmin/widgets/updatingServiceDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/colors.dart';
import '../widgets/OrderingServiceDialog.dart';

class ServiceDetailsScreen extends StatelessWidget {
  Service service;
  ServiceDetailsScreen(this.service);

//   Service service;
// ServiceDetailsScreen(this.service);
  @override
  Widget build(BuildContext context) {
    print('${service.logoImgURL} hnaa');
    ServicesCubit servicesCubit = BlocProvider.of<ServicesCubit>(context);
    servicesCubit.serviceID = service.id;
    servicesCubit.servicePictureURL = service.logoImgURL;
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                BlocBuilder<ServicesCubit, ServicesState>(
                  builder: (context, state) {
                    return state is ServicePictureLoading
                        ? Container(
                            height: 320.h,
                            child: Center(
                              child: SpinKitCircle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Stack(children: [
                            Container(
                              height: 320.h,
                              width: double.infinity,
                              child: servicesCubit.servicePictureURL == ''
                                  ? GestureDetector(
                                      onTap: () {
                                        servicesCubit.getImage();
                                      },
                                      child: Image.asset(
                                        'img/addpic.jpg',
                                        fit: BoxFit.cover,
                                      ))
                                  : Image.network(
                                      servicesCubit.servicePictureURL!,
                                      fit: BoxFit.fitHeight),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  servicesCubit.getImage();
                                },
                                child: Container(
                                  height: 270.h,
                                  child: Align(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white30,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        )),
                                    alignment: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                          ]);
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 280.h,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r)),
                      child: Container(
                        decoration: BoxDecoration(
                            ////////////////////////  color /////////////////////////////
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r))),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                (Localizations.localeOf(context).languageCode ==
                                        'ar')
                                    ? service.AR['serviceName']
                                    : service.EN['serviceName'],
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          (Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'ar')
                                              ? service.AR['serviceDesc']
                                              : service.EN['serviceDesc'],
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).What_We_Offer_You,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              OurProvidingListItem(Icons.engineering,
                                  S.of(context).expert_technicians),
                              OurProvidingListItem(Icons.shield_outlined,
                                  S.of(context).service_guarantee),
                              OurProvidingListItem(
                                  Icons.sentiment_very_satisfied,
                                  S.of(context).customer_satisfaction),
                              OurProvidingListItem(
                                  Icons.money_off, S.of(context).best_prices),
                              OurProvidingListItem(Icons.verified,
                                  S.of(context).money_back_guarantee),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  ////////////////////////  color /////////////////////////////
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: MyButton(
                      text: 'تعديل الخدمة',
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                UpdatingServiceDialog(service));
                      },
                      // textColor: Theme.of(context).focusColor,
                      // textColor: Colors.black,
                      // buttonColor: FxColors.primary),
                      textColor: Theme.of(context).hintColor,
                      buttonColor: Theme.of(context).primaryColor),
                  // buttonColor: Theme.of(context).primaryColor),
                )
              ],
            ),
            // customAppbar(title: S.of(context).service_request),
          ]),
        ),
      ),
    );
  }
}
