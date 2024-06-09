import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AppVersionNetwork {
  final CollectionReference _AppVersion =
      FirebaseFirestore.instance.collection('appversion');

  Future<List<AppVersionModel>> getAppVersion(AppVersionModelDataList) async {
    // List<AppVersionModel> AppVersionModelDataList = [];
    List<QueryDocumentSnapshot> AppVersionDataQueryList = [];
    QuerySnapshot querySnapshot = await _AppVersion.get();
    AppVersionDataQueryList.addAll(querySnapshot.docs);
    log('طول الليست ${AppVersionDataQueryList.length}');
    log(' اليستة  فيها $AppVersionDataQueryList');
    for (int i = 0; i < AppVersionDataQueryList.length; i++) {
      AppVersionModelDataList.add(AppVersionModel(
          versionName: AppVersionDataQueryList[i]['versionName'].toString(),
          versionCode: AppVersionDataQueryList[i]['versionCode'].toString(),
          minVersion: AppVersionDataQueryList[i]['minVersion'].toString(),
          showIgnore: AppVersionDataQueryList[i]['showIgnore'],
          showLater: AppVersionDataQueryList[i]['showLater']));
    }
    debugPrint('hna ba3d forLoop');
    log(' اليستة  فيها $AppVersionDataQueryList');

    return AppVersionModelDataList;
  }
}

class AppVersionModel {
  final String versionName;
  final String versionCode;
  final String minVersion;
  bool showIgnore;
  bool showLater;
  AppVersionModel(
      {required this.versionName,
      required this.versionCode,
      required this.minVersion,
      this.showIgnore = false,
      this.showLater = false});
  factory AppVersionModel.fromFirebase(dynamic data) {
    return AppVersionModel(
        versionName: data['versionName'],
        versionCode: data['versionCode'],
        minVersion: data['minVersion'],
        showIgnore: data['showIgnore'],
        showLater: data['showLater']);
  }
}
