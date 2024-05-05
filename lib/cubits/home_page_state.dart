part of 'home_page_cubit.dart';

// @immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class HomePageGetDataSuccessed extends HomePageState {}
class HomePageGetDataLoading extends HomePageState {}
class HomePageGetDataFailure extends HomePageState {
  String errorMsg;
  HomePageGetDataFailure(this.errorMsg);
}
class changingSwitchState extends HomePageState {}

class AddingCategorySuccessState extends HomePageState {}

class AddingCategoryLoadingState extends HomePageState {}

class AddingCategoryFailureState extends HomePageState {}
class CategoryPictureLoading extends HomePageState {}
class CategoryPictureChanged extends HomePageState {}
class UpdatingCategoryLoading extends HomePageState {}
class UpdatingCategorySuccessState extends HomePageState {}



