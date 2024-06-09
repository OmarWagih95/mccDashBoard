
abstract class AppVersionState {}

class AppVersionInitial extends AppVersionState {}

class AppVersionGetDataSuccessed extends AppVersionState {}

class AppVersionGetDataLoading extends AppVersionState {}

class AppVersionGetDataFailure extends AppVersionState {
  String errorMsg;
  AppVersionGetDataFailure(this.errorMsg);
}

