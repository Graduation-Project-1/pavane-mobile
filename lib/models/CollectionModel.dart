// ignore_for_file: prefer_typing_uninitialized_variables

class CollectionModel {
  CollectionModel({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  CollectionModel.fromJson(dynamic json) {
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
      this.name, 
      this.date, 
      this.numberOfReviews, 
      this.numberOfLikes, 
      this.averageRate, 
      this.discountRate, 
      this.itemsList, 
      this.categoryList, 
      this.brandId, 
      this.v, 
      this.image,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    date = json['date'];
    numberOfReviews = json['numberOfReviews'];
    numberOfLikes = json['numberOfLikes'];
    averageRate = json['averageRate'];
    discountRate = json['discountRate'];
    if (json['itemsList'] != null) {
      itemsList = [];
      json['itemsList'].forEach((v) {
        itemsList?.add(ItemsList.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    brandId = json['brandId'] != null ? BrandId.fromJson(json['brandId']) : null;
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? date;
  int? numberOfReviews;
  int? numberOfLikes;
  var averageRate;
  var discountRate;
  List<ItemsList>? itemsList;
  List<CategoryList>? categoryList;
  BrandId? brandId;
  int? v;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['date'] = date;
    map['numberOfReviews'] = numberOfReviews;
    map['numberOfLikes'] = numberOfLikes;
    map['averageRate'] = averageRate;
    map['discountRate'] = discountRate;
    if (itemsList != null) {
      map['itemsList'] = itemsList?.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    if (brandId != null) {
      map['brandId'] = brandId?.toJson();
    }
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}

class BrandId {
  BrandId({
      this.id, 
      this.name, 
      this.email, 
      this.password, 
      this.role, 
      this.numberOfLikes, 
      this.numberOfReviews, 
      this.averageRate, 
      this.phone, 
      this.categoryList, 
      this.image,});

  BrandId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    numberOfLikes = json['numberOfLikes'];
    numberOfReviews = json['numberOfReviews'];
    averageRate = json['averageRate'];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    image = json['image'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  int? numberOfLikes;
  int? numberOfReviews;
  var averageRate;
  List<String>? phone;
  List<String>? categoryList;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['numberOfLikes'] = numberOfLikes;
    map['numberOfReviews'] = numberOfReviews;
    map['averageRate'] = averageRate;
    map['phone'] = phone;
    map['categoryList'] = categoryList;
    map['image'] = image;
    return map;
  }

}

class CategoryList {
  CategoryList({
      this.id, 
      this.name, 
      this.image,});

  CategoryList.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}

class ItemsList {
  ItemsList({
      this.id, 
      this.categoryList, 
      this.name, 
      this.brandId, 
      this.price, 
      this.description, 
      this.images, 
      this.numberOfReviews, 
      this.averageRate, 
      this.numberOfLikes, 
      this.gender, 
      this.sizes, 
      this.colors, 
      this.isAdult,});

  ItemsList.fromJson(dynamic json) {
    id = json['_id'];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    name = json['name'];
    brandId = json['brandId'];
    price = json['price'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    numberOfReviews = json['numberOfReviews'];
    averageRate = json['averageRate'];
    numberOfLikes = json['numberOfLikes'];
    gender = json['gender'];
    sizes = json['sizes'] != null ? json['sizes'].cast<String>() : [];
    if (json['colors'] != null) {
      colors = [];
      json['colors'].forEach((v) {
        colors?.add(v);
      });
    }
    isAdult = json['isAdult'];
  }
  String? id;
  List<String>? categoryList;
  String? name;
  String? brandId;
  int? price;
  String? description;
  List<String>? images;
  int? numberOfReviews;
  var averageRate;
  int? numberOfLikes;
  String? gender;
  List<String>? sizes;
  List<dynamic>? colors;
  bool? isAdult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['categoryList'] = categoryList;
    map['name'] = name;
    map['brandId'] = brandId;
    map['price'] = price;
    map['description'] = description;
    map['images'] = images;
    map['numberOfReviews'] = numberOfReviews;
    map['averageRate'] = averageRate;
    map['numberOfLikes'] = numberOfLikes;
    map['gender'] = gender;
    map['sizes'] = sizes;
    if (colors != null) {
      map['colors'] = colors?.map((v) => v.toJson()).toList();
    }
    map['isAdult'] = isAdult;
    return map;
  }

}