import 'package:MccAdmin/cubits/auth_cubit.dart';
import 'package:MccAdmin/cubits/order_cubit.dart';
import 'package:MccAdmin/generated/l10n.dart';
import 'package:MccAdmin/model/category.dart';
import 'package:MccAdmin/views/navpages/main_page%20copy.dart';
import 'package:MccAdmin/widgets/MyButtonW.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';
import '../cubits/services_cubit.dart';
import '../model/service.dart';

class UpdatingServiceDialog extends StatelessWidget {
  Service service;
  UpdatingServiceDialog(this.service);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        if (state is UpdatingServiceSuccessState) {
          Fluttertoast.showToast(msg: 'تمت تعديل الخدمة بنجاح');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        ServicesCubit ServiceCubit = BlocProvider.of<ServicesCubit>(context);
        ServiceCubit.arServiceName = service.AR['serviceName'];
        ServiceCubit.enServiceName = service.EN['serviceName'];
        ServiceCubit.ardescription = service.AR['serviceDesc'];
        ServiceCubit.endescription = service.EN['serviceDesc'];
        // ServiceCubit.categoryID=categoryy.id;
        return BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {
            if (state is UpdatingServiceSuccessState) {
              Fluttertoast.showToast(msg: 'تم تعديل الخدمة بنجاح');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => mainpage(
                      is_login: true,
                      navigationIndexfromRouting: 2,
                    ),
                  ));
            }
          },
          builder: (context, state) {
            return Dialog(
              // backgroundColor: Colors.white,
              // surfaceTintColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
              child: state is AddingServiceLoadingState
                  ? Container(
                      width: 600.w,
                      height: 600.h,
                      child: Center(
                        child: SpinKitCircle(
                          color: Colors.black45,
                        ),
                      ),
                    )
                  : Container(
                      width: 600.w,
                      height: 600.h,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              // S.of(context).service_confirmation,
                              'تعديل الخدمة',
                              style: TextStyle(
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                            Expanded(
                              child: Form(
                                  key: ServiceCubit.orderFormKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Column(
                                            // mainAxisAlignment:
                                            // MainAxisAlignment.end,
                                            children: [
                                              // Card(
                                              //   color:
                                              //   Theme.of(context).primaryColor,
                                              //   elevation: 2,
                                              //   child: Padding(
                                              //     padding:
                                              //     const EdgeInsets.symmetric(
                                              //         horizontal: 8,
                                              //         vertical: 5),
                                              //     child: Text(
                                              //       (Localizations.localeOf(context)
                                              //           .languageCode ==
                                              //           'ar')
                                              //           ? service.AR['serviceName']
                                              //           : service.EN['serviceName'],
                                              //       style: TextStyle(
                                              //           fontSize: 16.w,
                                              //           fontWeight:
                                              //           FontWeight.bold),
                                              //     ),
                                              //   ),
                                              // ),
                                              // Text(
                                              //   '${S.of(context).Please_write_the_description} :',
                                              //   style: TextStyle(
                                              //       fontSize: 16.w,
                                              //       fontWeight: FontWeight.bold),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('اسم الخدمة باللغة العربية'),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            initialValue:
                                                ServiceCubit.arServiceName,
                                            textDirection: TextDirection.rtl,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                ServiceCubit.arServiceName =
                                                    value;
                                              } else if (value.isEmpty) {
                                                // ServiceCubit.address =
                                                return 'من فضلك ادخل اسم الخدمة';
                                              }
                                            },
                                            // minLines: 3,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ColorsManager.lighterGray,
                                              filled: true,
                                              // hintText: BlocProvider.of<AuthCubit>(
                                              //         context)
                                              //     .user!
                                              //     .phoneNumber!,
                                              // hintText:S.of(context).contact_number_prompt,
                                              // hintTextDirection: TextDirection.rtl,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.h,
                                                      vertical: 18.h),
                                              enabledBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder,
                                              focusedBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .focusedBorder,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                'اسم الخدمة باللغة الإنجليزية'),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            initialValue:
                                                ServiceCubit.enServiceName,
                                            textDirection: TextDirection.rtl,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                ServiceCubit.enServiceName =
                                                    value;
                                              } else if (value.isEmpty) {
                                                // ServiceCubit.address =
                                                return 'من فضلك ادخل اسم الخدمة';
                                              }
                                            },
                                            // minLines: 3,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ColorsManager.lighterGray,
                                              filled: true,
                                              // hintText: BlocProvider.of<AuthCubit>(
                                              //         context)
                                              //     .user!
                                              //     .phoneNumber!,
                                              // hintText:S.of(context).contact_number_prompt,
                                              // hintTextDirection: TextDirection.rtl,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.h,
                                                      vertical: 18.h),
                                              enabledBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder,
                                              focusedBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .focusedBorder,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('وصف الخدمة باللغة العربية'),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            initialValue:
                                                ServiceCubit.ardescription,
                                            textDirection: TextDirection.rtl,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                ServiceCubit.ardescription =
                                                    value;
                                              } else if (value.isEmpty) {
                                                // ServiceCubit.address =
                                                return 'من فضلك ادخل اسم الخدمة';
                                              }
                                            },
                                            // minLines: 3,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ColorsManager.lighterGray,
                                              filled: true,
                                              // hintText: BlocProvider.of<AuthCubit>(
                                              //         context)
                                              //     .user!
                                              //     .phoneNumber!,
                                              // hintText:S.of(context).contact_number_prompt,
                                              // hintTextDirection: TextDirection.rtl,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.h,
                                                      vertical: 18.h),
                                              enabledBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder,
                                              focusedBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .focusedBorder,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                'وصف الخدمة باللغة الإنجليزية'),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            initialValue:
                                                ServiceCubit.endescription,
                                            textDirection: TextDirection.rtl,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                ServiceCubit.endescription =
                                                    value;
                                              } else if (value.isEmpty) {
                                                // ServiceCubit.address =
                                                return 'من فضلك ادخل اسم الخدمة';
                                              }
                                            },
                                            // minLines: 3,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ColorsManager.lighterGray,
                                              filled: true,
                                              // hintText: BlocProvider.of<AuthCubit>(
                                              //         context)
                                              //     .user!
                                              //     .phoneNumber!,
                                              // hintText:S.of(context).contact_number_prompt,
                                              // hintTextDirection: TextDirection.rtl,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.h,
                                                      vertical: 18.h),
                                              enabledBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder,
                                              focusedBorder: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .focusedBorder,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                      ],
                                    ),
                                  )),
                            ),
                            state is UpdatingServiceLoading
                                ? Center(
                                    child: SpinKitCircle(
                                      color: Colors.white30,
                                    ),
                                  )
                                : MyButton(
                                    text: 'تعديل',
                                    // text: S.of(context).confirmation,
                                    onClick: () {
                                      if (ServiceCubit
                                          .orderFormKey.currentState!
                                          .validate()) {
                                        ServiceCubit.updatingService();

                                        // );
                                        print('tmaaaaam');
                                      }
                                    },
                                    textColor: Theme.of(context).hintColor,
                                    buttonColor: Theme.of(context).primaryColor)
                          ],
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
