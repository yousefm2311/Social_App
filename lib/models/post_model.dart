class NewPostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? imagePost;

  NewPostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.image,
    this.text,
    this.imagePost,
  });

  NewPostModel.formJson(Map<String, dynamic> json) {
    name = json["name"];
    uId = json["uId"];
    image = json["image"];
    dateTime = json["dateTime"];
    text = json["text"];

    imagePost = json["imagePost"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'imagePost': imagePost,
    };
  }
}
