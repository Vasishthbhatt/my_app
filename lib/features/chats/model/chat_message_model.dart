class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.content,
      required this.sentTime,
      required this.messageType});

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'senderId': senderId,
        'content': content,
        'sentTime': sentTime.toIso8601String(),
        'messageType': messageType.toJson()
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        receiverId: json["receiverId"],
        senderId: json["senderId"],
        content: json["content"],
        sentTime: DateTime.parse(json["sentTime"]),
        messageType: MessageType.values.byName(json["messageType"]),
      );
}

enum MessageType {
  text,
  image;

  String toJson() => name;
}
