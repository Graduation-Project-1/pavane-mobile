class AdsModel {
  AdsModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  AdsModel.fromJson(dynamic json) {
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
      this.name, 
      this.link, 
      this.startDate, 
      this.endDate, 
      this.creatorName, 
      this.isArchived, 
      this.v, 
      this.image,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    link = json['link'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    creatorName = json['creatorName'];
    isArchived = json['isArchived'];
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? link;
  String? startDate;
  String? endDate;
  String? creatorName;
  bool? isArchived;
  int? v;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['link'] = link;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['creatorName'] = creatorName;
    map['isArchived'] = isArchived;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}