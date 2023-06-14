// ignore_for_file: prefer_typing_uninitialized_variables

class ReviewModel {
  ReviewModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  ReviewModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    totalResult = json['totalResult'];
    totalPages = json['totalPages'];
  }
  bool? success;
  int? status;
  String? message;
  List<Data>? data;
  int? totalResult;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    map['totalResult'] = totalResult;
    map['totalPages'] = totalPages;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.comment, 
      this.rate, 
      this.date, 
      this.customerId, 
      this.isArchived,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    comment = json['comment'];
    rate = json['rate'];
    date = json['date'];
    customerId = json['customerId'] != null ? CustomerId.fromJson(json['customerId']) : null;
    isArchived = json['isArchived'];
  }
  String? id;
  String? comment;
  var rate;
  String? date;
  CustomerId? customerId;
  bool? isArchived;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['comment'] = comment;
    map['rate'] = rate;
    map['date'] = date;
    if (customerId != null) {
      map['customerId'] = customerId?.toJson();
    }
    map['isArchived'] = isArchived;
    return map;
  }

}

class CustomerId {
  CustomerId({
      this.id, 
      this.name,});

  CustomerId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}