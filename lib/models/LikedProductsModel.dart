class LikedProductsModel {
  LikedProductsModel({
      this.likedItems,});

  LikedProductsModel.fromJson(dynamic json) {
    if (json['likedItems'] != null) {
      likedItems = [];
      json['likedItems'].forEach((v) {
        likedItems?.add(LikedItems.fromJson(v));
      });
    }
  }
  List<LikedItems>? likedItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (likedItems != null) {
      map['likedItems'] = likedItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LikedItems {
  LikedItems({
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

  LikedItems.fromJson(dynamic json) {
    id = json['_id'];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    name = json['name'];
    brandId = json['brandId'] != null ? BrandId.fromJson(json['brandId']) : null;
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
  BrandId? brandId;
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
    if (brandId != null) {
      map['brandId'] = brandId?.toJson();
    }
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

class BrandId {
  BrandId({
      this.id, 
      this.name,});

  BrandId.fromJson(dynamic json) {
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