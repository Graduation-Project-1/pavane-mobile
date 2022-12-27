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
      this.name, 
      this.price, 
      this.description, 
      this.numberOfReviews, 
      this.numberOfLikes, 
      this.averageRate, 
      this.gender, 
      this.isAdult, 
      this.discountRate, 
      this.images, 
      this.sizes, 
      this.colors, 
      this.brandId, 
      this.categoryList, 
      this.v, 
      this.cover,});

  LikedItems.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    numberOfReviews = json['numberOfReviews'];
    numberOfLikes = json['numberOfLikes'];
    averageRate = json['averageRate'];
    gender = json['gender'];
    isAdult = json['isAdult'];
    discountRate = json['discountRate'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    sizes = json['sizes'] != null ? json['sizes'].cast<String>() : [];
    colors = json['colors'] != null ? json['colors'].cast<String>() : [];
    brandId = json['brandId'];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    v = json['__v'];
    cover = json['cover'];
  }
  String? id;
  String? name;
  int? price;
  String? description;
  int? numberOfReviews;
  int? numberOfLikes;
  int? averageRate;
  String? gender;
  bool? isAdult;
  int? discountRate;
  List<String>? images;
  List<String>? sizes;
  List<String>? colors;
  String? brandId;
  List<String>? categoryList;
  int? v;
  String? cover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['numberOfReviews'] = numberOfReviews;
    map['numberOfLikes'] = numberOfLikes;
    map['averageRate'] = averageRate;
    map['gender'] = gender;
    map['isAdult'] = isAdult;
    map['discountRate'] = discountRate;
    map['images'] = images;
    map['sizes'] = sizes;
    map['colors'] = colors;
    map['brandId'] = brandId;
    map['categoryList'] = categoryList;
    map['__v'] = v;
    map['cover'] = cover;
    return map;
  }

}