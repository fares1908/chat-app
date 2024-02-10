class ChatMessage {
  String? message;
  String? sendByMe;
  String? time;
  String? targetId;
  String? imagePath; // تضمين خاصية الصورة

  ChatMessage({
    this.message,
    this.sendByMe,
    this.time,
    this.targetId,
    this.imagePath,
  });

  ChatMessage.fromJson(json) {
    message = json['message'];
    sendByMe = json['sendByMe'];
    time = json['time'];
    targetId = json['targetId'];
    imagePath = json['imagePath']; // تحديث ليتناسب مع اسم الخاصية
  }
}
