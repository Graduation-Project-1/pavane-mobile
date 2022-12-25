class UserModel {
  UserModel({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  UserModel.fromJson(dynamic json) {
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
      this.email, 
      this.dateOfBirth, 
      this.phone, 
      this.gender, 
      this.location, 
      this.image, 
      this.cardNumber, 
      this.numberOfPeopleUseReferralLink, 
      this.wishList, 
      this.vendorLikes, 
      this.productLikes, 
      this.collectionList, 
      this.role, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    gender = json['gender'];
    location = json['location'];
    image = json['image'];
    if (json['cardNumber'] != null) {
      cardNumber = [];
      json['cardNumber'].forEach((v) {
        cardNumber?.add(v);
      });
    }
    numberOfPeopleUseReferralLink = json['numberOfPeopleUseReferralLink'];
    if (json['wishList'] != null) {
      wishList = [];
      json['wishList'].forEach((v) {
        wishList?.add(v);
      });
    }
    if (json['vendorLikes'] != null) {
      vendorLikes = [];
      json['vendorLikes'].forEach((v) {
        vendorLikes?.add(v);
      });
    }
    if (json['productLikes'] != null) {
      productLikes = [];
      json['productLikes'].forEach((v) {
        productLikes?.add(v);
      });
    }
    if (json['collectionList'] != null) {
      collectionList = [];
      json['collectionList'].forEach((v) {
        collectionList?.add(v);
      });
    }
    role = json['role'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? email;
  String? dateOfBirth;
  String? phone;
  String? gender;
  String? location;
  String? image;
  List<dynamic>? cardNumber;
  int? numberOfPeopleUseReferralLink;
  List<dynamic>? wishList;
  List<dynamic>? vendorLikes;
  List<dynamic>? productLikes;
  List<dynamic>? collectionList;
  String? role;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['dateOfBirth'] = dateOfBirth;
    map['phone'] = phone;
    map['gender'] = gender;
    map['location'] = location;
    map['image'] = image;
    if (cardNumber != null) {
      map['cardNumber'] = cardNumber?.map((v) => v.toJson()).toList();
    }
    map['numberOfPeopleUseReferralLink'] = numberOfPeopleUseReferralLink;
    if (wishList != null) {
      map['wishList'] = wishList?.map((v) => v.toJson()).toList();
    }
    if (vendorLikes != null) {
      map['vendorLikes'] = vendorLikes?.map((v) => v.toJson()).toList();
    }
    if (productLikes != null) {
      map['productLikes'] = productLikes?.map((v) => v.toJson()).toList();
    }
    if (collectionList != null) {
      map['collectionList'] = collectionList?.map((v) => v.toJson()).toList();
    }
    map['role'] = role;
    map['__v'] = v;
    return map;
  }

}