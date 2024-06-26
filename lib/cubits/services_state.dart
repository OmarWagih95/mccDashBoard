part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

// class ServicesInitial extends ServicesState {}
class ServicesPageLoading extends ServicesState {}
class ServicesPageSuccess extends ServicesState {
  List<Service> servicesDataList=[];
  ServicesPageSuccess(this.servicesDataList);

}
class ServicesPagaeFailure extends ServicesState {
  String error;
  ServicesPagaeFailure(this.error);
}
class AddingServiceSuccessState extends ServicesState{}
class AddingServiceLoadingState extends ServicesState{}
class AddingServiceFailureState extends ServicesState{}
class ServicePictureChanged extends ServicesState{}
class ServicePictureLoading extends ServicesState{}
class UpdatingServiceSuccessState extends ServicesState{}
class UpdatingServiceLoading extends ServicesState{}
