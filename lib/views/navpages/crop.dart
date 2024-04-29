import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class cropScreen extends StatefulWidget {
  const cropScreen({Key? key}) : super(key: key);

  @override
  State<cropScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<cropScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select & Crop Image'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            imageFile == null
                ? Image.asset(
                    'img/addpic.jpg',
                    height: 300.0,
                    width: 300.0,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.file(
                      imageFile!,
                      height: 300.0,
                      width: 300.0,
                      fit: BoxFit.fill,
                    )),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                // Map<Permission, PermissionStatus> statuses = await [
                //   Permission.storage,
                //   Permission.camera,
                // ].request();
                // if (statuses[Permission.storage]!.isGranted &&
                //     statuses[Permission.camera]!.isGranted) {
                //   showImagePicker(context);
                // }
                showImagePicker(context);
              },
              child: Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ScaffoldMessenger___cropImage ')));
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// /// A Flutter application demonstrating the functionality of this plugin
// class HomeScreen extends StatefulWidget {
//   /// Create a page containing the functionality of this plugin

//   @override
//   HomeScreenState createState() =>
//       HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//           children: Permission.values
//               .where((permission) {
//                 if (Platform.isIOS) {
//                   return permission != Permission.unknown &&
//                       permission != Permission.phone &&
//                       permission != Permission.sms &&
//                       permission != Permission.ignoreBatteryOptimizations &&
//                       permission != Permission.accessMediaLocation &&
//                       permission != Permission.activityRecognition &&
//                       permission != Permission.manageExternalStorage &&
//                       permission != Permission.systemAlertWindow &&
//                       permission != Permission.requestInstallPackages &&
//                       permission != Permission.accessNotificationPolicy &&
//                       permission != Permission.bluetoothScan &&
//                       permission != Permission.bluetoothAdvertise &&
//                       permission != Permission.bluetoothConnect &&
//                       permission != Permission.nearbyWifiDevices &&
//                       permission != Permission.videos &&
//                       permission != Permission.audio &&
//                       permission != Permission.scheduleExactAlarm &&
//                       permission != Permission.sensorsAlways;
//                 } else {
//                   return permission != Permission.unknown &&
//                       permission != Permission.mediaLibrary &&
//                       permission != Permission.photosAddOnly &&
//                       permission != Permission.reminders &&
//                       permission != Permission.bluetooth &&
//                       permission != Permission.appTrackingTransparency &&
//                       permission != Permission.criticalAlerts &&
//                       permission != Permission.assistant;
//                 }
//               })
//               .map((permission) => PermissionWidget(permission))
//               .toList()),
//     );
//   }
// }

// /// Permission widget containing information about the passed [Permission]
// class PermissionWidget extends StatefulWidget {
//   /// Constructs a [PermissionWidget] for the supplied [Permission]
//   const PermissionWidget(this._permission);

//   final Permission _permission;

//   @override
//   _PermissionState createState() => _PermissionState(_permission);
// }

// class _PermissionState extends State<PermissionWidget> {
//   _PermissionState(this._permission);

//   final Permission _permission;
//   PermissionStatus _permissionStatus = PermissionStatus.denied;

//   @override
//   void initState() {
//     super.initState();

//     _listenForPermissionStatus();
//   }

//   void _listenForPermissionStatus() async {
//     final status = await _permission.status;
//     setState(() => _permissionStatus = status);
//   }

//   Color getPermissionColor() {
//     switch (_permissionStatus) {
//       case PermissionStatus.denied:
//         return Colors.red;
//       case PermissionStatus.granted:
//         return Colors.green;
//       case PermissionStatus.limited:
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         _permission.toString(),
//         style: Theme.of(context).textTheme.bodyLarge,
//       ),
//       subtitle: Text(
//         _permissionStatus.toString(),
//         style: TextStyle(color: getPermissionColor()),
//       ),
//       trailing: (_permission is PermissionWithService)
//           ? IconButton(
//               icon: const Icon(
//                 Icons.info,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 checkServiceStatus(
//                     context, _permission as PermissionWithService);
//               })
//           : null,
//       onTap: () {
//         requestPermission(_permission);
//       },
//     );
//   }

//   void checkServiceStatus(
//       BuildContext context, PermissionWithService permission) async {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text((await permission.serviceStatus).toString()),
//     ));
//   }

//   Future<void> requestPermission(Permission permission) async {
//     final status = await permission.request();

//     setState(() {
//       print(status);
//       _permissionStatus = status;
//       print(_permissionStatus);
//     });
//   }
// }
