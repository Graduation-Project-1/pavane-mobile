class AllCollectionsModel {
  AllCollectionsModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  AllCollectionsModel.fromJson(dynamic json) {
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
      this.season, 
      this.date, 
      this.numberOfLikes, 
      this.itemsList, 
      this.categoryList, 
      this.brandId, 
      this.v, 
      this.image,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    season = json['season'];
    date = json['date'];
    numberOfLikes = json['numberOfLikes'];
    itemsList = json['itemsList'] != null ? json['itemsList'].cast<String>() : [];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    brandId = json['brandId'];
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? season;
  String? date;
  int? numberOfLikes;
  List<String>? itemsList;
  List<String>? categoryList;
  String? brandId;
  int? v;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['season'] = season;
    map['date'] = date;
    map['numberOfLikes'] = numberOfLikes;
    map['itemsList'] = itemsList;
    map['categoryList'] = categoryList;
    map['brandId'] = brandId;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}