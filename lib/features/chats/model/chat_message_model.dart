class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  Message({required this.senderId, required this.receiverId, required this.content, required this.sentTime, required this.messageType});

}

enum MessageType{
    text,
    image;
}
