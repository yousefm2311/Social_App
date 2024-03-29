class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  String? token;
  bool? isVerified;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isVerified,
    this.image,
    this.bio,
    this.cover,
    this.token
  });

  SocialUserModel.formJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    uId = json["uId"];
    image = json["image"];
    bio = json["bio"];
    cover = json["cover"];
    token = json["token"];

    isVerified = json["isVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      "phone": phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'token': token,
      'isVerified': isVerified
    };
  }
}
