import 'package:MCCAdmin/cubits/AppVersionState.dart';
import 'package:MCCAdmin/model/network/appVersion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit() : super(AppVersionInitial());
  List<AppVersionModel> AppVersionDataList = [];
  getAppVersion() async {
    try {
      AppVersionDataList.clear();
      AppVersionDataList =
          await AppVersionNetwork().getAppVersion(AppVersionDataList);
      emit(AppVersionGetDataSuccessed());
    } catch (e) {
      emit(AppVersionGetDataFailure(e.toString()));
    }
  }
}
