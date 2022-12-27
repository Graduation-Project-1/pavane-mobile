class LikedBrandsModel {
  LikedBrandsModel({
      this.likedBrands,});

  LikedBrandsModel.fromJson(dynamic json) {
    if (json['likedBrands'] != null) {
      likedBrands = [];
      json['likedBrands'].forEach((v) {
        likedBrands?.add(LikedBrands.fromJson(v));
      });
    }
  }
  List<LikedBrands>? likedBrands;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (likedBrands != null) {
      map['likedBrands'] = likedBrands?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LikedBrands {
  LikedBrands({
      this.id, 
      this.name, 
      this.email, 
      this.password, 
      this.numberOfLikes, 
      this.phone, 
      this.categoryList, 
      this.role, 
      this.v, 
      this.image, 
      this.coverImage,});

  LikedBrands.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    numberOfLikes = json['numberOfLikes'];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    role = json['role'];
    v = json['__v'];
    image = json['image'];
    coverImage = json['coverImage'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  int? numberOfLikes;
  List<String>? phone;
  List<String>? categoryList;
  String? role;
  int? v;
  String? image;
  String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['numberOfLikes'] = numberOfLikes;
    map['phone'] = phone;
    map['categoryList'] = categoryList;
    map['role'] = role;
    map['__v'] = v;
    map['image'] = image;
    map['coverImage'] = coverImage;
    return map;
  }

}