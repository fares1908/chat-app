class ChatMessage {
  String? message;
  String? sendByMe;
  String? time;
  String ? targetId;

  ChatMessage({
    this.message,
    this.sendByMe,
    this.time,
    this.targetId,
  });

  ChatMessage.fromJson(json) {
    message = json['message'];
    sendByMe = json['sendByMe'];
    time = json['time'];
    targetId=json['targetId'];
  }
}
