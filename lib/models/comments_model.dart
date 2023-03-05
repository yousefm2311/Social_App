class CommentModel {
  String? image;
  String? text;
  String? dateTime;
  String? uId;
  String? name;
  String? imageUser;
  CommentModel.fromJson(Map<String, dynamic> json) {
    image = json["image"];
    text = json["text"];
    dateTime = json["dateTime"];
    uId = json["uId"];
    name = json["name"];
    imageUser = json["imageUser"];
  }
  CommentModel({
    this.image,
    this.text,
    this.dateTime,
    this.uId,
    this.name,
    this.imageUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'image' :image,
      'name' :name,
      'text' :text,
      'dateTime' :dateTime,
      'uId' :uId,
      'imageUser' :imageUser,
    };
  }
}
