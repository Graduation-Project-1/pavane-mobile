class LikedCollectionsModel {
  LikedCollectionsModel({
      this.likedCollections,});

  LikedCollectionsModel.fromJson(dynamic json) {
    if (json['likedCollections'] != null) {
      likedCollections = [];
      json['likedCollections'].forEach((v) {
        likedCollections?.add(LikedCollections.fromJson(v));
      });
    }
  }
  List<LikedCollections>? likedCollections;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (likedCollections != null) {
      map['likedCollections'] = likedCollections?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LikedCollections {
  LikedCollections({
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

  LikedCollections.fromJson(dynamic json) {
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