import 'package:MccAdmin/cubits/auth_cubit.dart';
import 'package:MccAdmin/cubits/order_cubit.dart';
import 'package:MccAdmin/generated/l10n.dart';
import 'package:MccAdmin/model/category.dart';
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

class AddingNewServiceDialog extends StatelessWidget {
  Categoryy categoryy;
  AddingNewServiceDialog(this.categoryy);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        if (state is AddingServiceSuccessState) {
          Fluttertoast.showToast(msg: 'تمت إضافة الخدمة بنجاح');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        ServicesCubit ServiceCubit = BlocProvider.of<ServicesCubit>(context);
        ServiceCubit.categoryID = categoryy.id;
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
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          // S.of(context).service_confirmation,
                          'إضافة خدمة',
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
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
                                    // Container(
                                    //   width: double.infinity,
                                    //   child: TextFormField(
                                    //     validator: (value) {
                                    //       if (value!.isEmpty) {
                                    //         return S
                                    //             .of(context)
                                    //             .Please_write_the_description;
                                    //       } else {
                                    //         // ServiceCubit.description = value;
                                    //       }
                                    //     },
                                    //     minLines: 4,
                                    //     maxLines: 6,
                                    //     decoration: InputDecoration(
                                    //       fillColor:
                                    //       ColorsManager.lighterGray,
                                    //       filled: true,
                                    //       hintText: S
                                    //           .of(context)
                                    //           .detailed_description_prompt,
                                    //       // hintTextDirection: TextDirection.rtl,
                                    //       contentPadding:
                                    //       EdgeInsets.symmetric(
                                    //           horizontal: 20.h,
                                    //           vertical: 18.h),
                                    //       enabledBorder: Theme.of(context)
                                    //           .inputDecorationTheme
                                    //           .enabledBorder,
                                    //       focusedBorder: Theme.of(context)
                                    //           .inputDecorationTheme
                                    //           .focusedBorder,),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 15.h,
                                    // ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('اسم الخدمة باللغة العربية'),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            ServiceCubit.arServiceName = value;
                                          } else if (value.isEmpty) {
                                            // ServiceCubit.address =
                                            return 'من فضلك ادخل اسم الخدمة';
                                          }
                                        },
                                        // minLines: 3,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          fillColor: ColorsManager.lighterGray,
                                          filled: true,
                                          // hintText: BlocProvider.of<AuthCubit>(
                                          //         context)
                                          //     .user!
                                          //     .phoneNumber!,
                                          // hintText:S.of(context).contact_number_prompt,
                                          // hintTextDirection: TextDirection.rtl,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 18.h),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('اسم الخدمة باللغة الإنجليزية'),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            ServiceCubit.enServiceName = value;
                                          } else if (value.isEmpty) {
                                            // ServiceCubit.address =
                                            return 'من فضلك ادخل اسم الخدمة';
                                          }
                                        },
                                        // minLines: 3,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          fillColor: ColorsManager.lighterGray,
                                          filled: true,
                                          // hintText: BlocProvider.of<AuthCubit>(
                                          //         context)
                                          //     .user!
                                          //     .phoneNumber!,
                                          // hintText:S.of(context).contact_number_prompt,
                                          // hintTextDirection: TextDirection.rtl,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 18.h),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('وصف الخدمة باللغة العربية'),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            ServiceCubit.ardescription = value;
                                          } else if (value.isEmpty) {
                                            // ServiceCubit.address =
                                            return 'من فضلك ادخل اسم الخدمة';
                                          }
                                        },
                                        // minLines: 3,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          fillColor: ColorsManager.lighterGray,
                                          filled: true,
                                          // hintText: BlocProvider.of<AuthCubit>(
                                          //         context)
                                          //     .user!
                                          //     .phoneNumber!,
                                          // hintText:S.of(context).contact_number_prompt,
                                          // hintTextDirection: TextDirection.rtl,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 18.h),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('وصف الخدمة باللغة الإنجليزية'),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            ServiceCubit.endescription = value;
                                          } else if (value.isEmpty) {
                                            // ServiceCubit.address =
                                            return 'من فضلك ادخل اسم الخدمة';
                                          }
                                        },
                                        // minLines: 3,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          fillColor: ColorsManager.lighterGray,
                                          filled: true,
                                          // hintText: BlocProvider.of<AuthCubit>(
                                          //         context)
                                          //     .user!
                                          //     .phoneNumber!,
                                          // hintText:S.of(context).contact_number_prompt,
                                          // hintTextDirection: TextDirection.rtl,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.h, vertical: 18.h),
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
                        MyButton(
                            text: S.of(context).confirmation,
                            onClick: () {
                              if (ServiceCubit.orderFormKey.currentState!
                                  .validate()) {
                                ServiceCubit.addNewService();
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
  }
}
