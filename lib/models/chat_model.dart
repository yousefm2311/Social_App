class ChatModel {
  String? text;
  String? receiverId;
  String? senderId;
  String? dateTime;

  ChatModel({
    this.text,
    this.receiverId,
    this.senderId,
    this.dateTime,
  });

  ChatModel.formJson(Map<String, dynamic> json) {
    text = json["text"];
    receiverId = json["receiverId"];
    senderId = json["senderId"];
    dateTime = json["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime,
    };
  }
}
