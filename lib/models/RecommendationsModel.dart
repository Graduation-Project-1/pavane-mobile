// ignore_for_file: prefer_typing_uninitialized_variables

class RecommendationsModel {
  RecommendationsModel({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  RecommendationsModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  bool? success;
  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.itemList,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    if (json['itemList'] != null) {
      itemList = [];
      json['itemList'].forEach((v) {
        itemList?.add(ItemList.fromJson(v));
      });
    }
  }
  String? id;
  List<ItemList>? itemList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (itemList != null) {
      map['itemList'] = itemList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ItemList {
  ItemList({
      this.isLiked, 
      this.hasModel, 
      this.id, 
      this.categoryList, 
      this.name, 
      this.brandId, 
      this.price, 
      this.description, 
      this.images, 
      this.gender, 
      this.date, 
      this.isAdult, 
      this.numberOfLikes, 
      this.averageRate, 
      this.numberOfReviews, 
      this.isArchived, 
      this.cover, 
      this.sizes, 
      this.colors,});

  ItemList.fromJson(dynamic json) {
    isLiked = json['isLiked'];
    hasModel = json['hasModel'];
    id = json['_id'];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    name = json['name'];
    brandId = json['brandId'];
    price = json['price'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    gender = json['gender'];
    date = json['date'];
    isAdult = json['isAdult'];
    numberOfLikes = json['numberOfLikes'];
    averageRate = json['averageRate'];
    numberOfReviews = json['numberOfReviews'];
    isArchived = json['isArchived'];
    cover = json['cover'];
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes?.add(v);
      });
    }
    if (json['colors'] != null) {
      colors = [];
      json['colors'].forEach((v) {
        colors?.add(v);
      });
    }
  }
  bool? isLiked;
  bool? hasModel;
  String? id;
  List<String>? categoryList;
  String? name;
  String? brandId;
  var price;
  String? description;
  List<String>? images;
  String? gender;
  String? date;
  bool? isAdult;
  int? numberOfLikes;
  var averageRate;
  int? numberOfReviews;
  bool? isArchived;
  String? cover;
  List<dynamic>? sizes;
  List<dynamic>? colors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isLiked'] = isLiked;
    map['hasModel'] = hasModel;
    map['_id'] = id;
    map['categoryList'] = categoryList;
    map['name'] = name;
    map['brandId'] = brandId;
    map['price'] = price;
    map['description'] = description;
    map['images'] = images;
    map['gender'] = gender;
    map['date'] = date;
    map['isAdult'] = isAdult;
    map['numberOfLikes'] = numberOfLikes;
    map['averageRate'] = averageRate;
    map['numberOfReviews'] = numberOfReviews;
    map['isArchived'] = isArchived;
    map['cover'] = cover;
    if (sizes != null) {
      map['sizes'] = sizes?.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      map['colors'] = colors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}