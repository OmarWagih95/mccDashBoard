import 'package:MCC/model/service.dart';

class OrderDetails {
  bool active;
  String address;
  String description;
  String phoneNumber;
  String serviceID;
  String userID;
  Service service;
  String orderID;
  OrderDetails(this.orderID,this.active,this.address,this.description,this.phoneNumber,this.userID,this.serviceID,this.service);
}