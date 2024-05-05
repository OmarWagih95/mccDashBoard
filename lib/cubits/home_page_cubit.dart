import 'dart:io';

import 'package:MCC/model/network/categoriesNetwork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../model/category.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
    GlobalKey<FormState> categoryFormKey = GlobalKey();

  String arCategoryName = '';
  String enCategoryName = '';
  String? servicePictureURL;
  File? imageFile = null;
  Uint8List webImage = Uint8List(8);

  HomePageCubit() : super(HomePageInitial());
  final CollectionReference _categories =FirebaseFirestore.instance.collection('categories');
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  List<Categoryy> categoryDataList = [];
  getCategoriesData() async {
    emit(HomePageGetDataLoading());
    try {
      categoryDataList.clear();
      categoryDataList =
          await CategoriesNetwork().getCategoriesData(categoryDataList);
      emit(HomePageGetDataSuccessed());
    } catch (e) {
      emit(HomePageGetDataFailure(e.toString()));
    }
  }

  bool darkMode = false;
  changeSwitch(bool x) {
    darkMode = x;
    emit(changingSwitchState());
  }

  addNewCategory() async {
    emit(AddingCategoryLoadingState());
    print('clicked');
    try {
      await CategoriesNetwork().addNewCategory({
        'serviceName': arCategoryName,
      }, {
        'serviceName': enCategoryName,
      });
      emit(AddingCategorySuccessState());
    } catch (e) {
      emit(AddingCategoryFailureState());
    }
  }

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    final choosedImage = await picker.pickImage(source: ImageSource.gallery);
    if (choosedImage == null) return;
    emit(CategoryPictureLoading());
// Pick an image.
    // if(kIsWeb){
    //   var f = await choosedImage!.readAsBytes();
    //
    //   webImage=f;
    //   imageFile=File('w');
    //   update();
    //   await FirebaseStorage.instance.ref().child('images/${userController.userID}').putData(
    //     webImage,
    //     SettableMetadata(contentType: 'image/jpeg'),
    //   );
    //   String value = await FirebaseStorage.instance.ref().child('images/${userController.userID}').getDownloadURL();
    //   print(value);
    //   profilePictureURL=value;
    //   update();
    // }
    if (!kIsWeb) {
      var f = await choosedImage!.readAsBytes();

      webImage = f;
      imageFile = File('w');
      print('started');
      print(choosedImage);

      imageFile = File(choosedImage.path);
      await FirebaseStorage.instance
          .ref()
          .child('images/CategoryImages/')
          .child('00')
          .putData(
            webImage,
            SettableMetadata(contentType: 'image/jpeg'),
          );
      String value = await FirebaseStorage.instance
          .ref()
          .child('images/servicesImages/00')
          .getDownloadURL();
      print(value);
      servicePictureURL = value;
      await _categories.doc('00').update({'image': servicePictureURL});
      emit(CategoryPictureChanged());
    }
  }

  // updatingService() async {
  //   emit(UpdatingCategoryLoading());
  //   try {
  //     await ServicesNetwork().updatingService(serviceID!, arServiceName,
  //         enServiceName, ardescription, endescription);
  //     emit(UpdatingCategorySuccessState());
  //   } catch (e) {}
  //   //TODO : lsa ht3mlha flnetwork wtdeha al 4 parameters ht3ml update ha!
  // }
}
