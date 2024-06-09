import 'dart:io';

import 'package:MCCAdmin/model/network/servicesNetwork.dart';
import 'package:MCCAdmin/model/service.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../model/network/servicesNetwork.dart';
import '../model/service.dart';

// import '../model/service.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  GlobalKey<FormState> orderFormKey = GlobalKey();
  File? imageFile = null;
  Uint8List webImage = Uint8List(8);
  String arServiceName = '';
  String enServiceName = '';
  String ardescription = '';
  String endescription = '';
  String categoryID = '';
  String serviceName = '';
  String? serviceID;
  String? servicePictureURL;

  ServicesCubit() : super(ServicesPageLoading());
  final CollectionReference _services =
      FirebaseFirestore.instance.collection('services');
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  List<Service> servicesDataList = [];
  getServicesData(String categoryID) async {
    emit(ServicesPageLoading());
    try {
      servicesDataList =
          await ServicesNetwork().getServicesData(categoryID, servicesDataList);
      print(servicesDataList.length);
      emit(ServicesPageSuccess(servicesDataList));
    } catch (e) {
      emit(ServicesPagaeFailure(e.toString()));
    }
  }

  addNewService() async {
    emit(AddingServiceLoadingState());
    print('clicked');
    try {
      await ServicesNetwork().addNewService(
          categoryID,
          {'serviceName': arServiceName, 'serviceDesc': ardescription},
          {'serviceName': enServiceName, 'serviceDesc': endescription});
      emit(AddingServiceSuccessState());
    } catch (e) {
      emit(AddingServiceFailureState());
    }
  }

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    final choosedImage = await picker.pickImage(source: ImageSource.gallery);
    if (choosedImage == null) return;
    emit(ServicePictureLoading());
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
          .child('images/servicesImages/')
          .child('${serviceID}')
          .putData(
            webImage,
            SettableMetadata(contentType: 'image/jpeg'),
          );
      String value = await FirebaseStorage.instance
          .ref()
          .child('images/servicesImages/${serviceID}')
          .getDownloadURL();
      print(value);
      servicePictureURL = value;
      await _services.doc(serviceID).update({'image': servicePictureURL});
      emit(ServicePictureChanged());
    }
  }

  updatingService() async {
    emit(UpdatingServiceLoading());
    try {
      await ServicesNetwork().updatingService(serviceID!, arServiceName,
          enServiceName, ardescription, endescription);
      emit(UpdatingServiceSuccessState());
    } catch (e) {}
    //TODO : lsa ht3mlha flnetwork wtdeha al 4 parameters ht3ml update ha!
  }
}
