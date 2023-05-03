class Message {
  final String message;
  final String senderUserId;
  final String receiverUserId;
  final DateTime sentOn;
  Message(
      {required this.message,
      required this.senderUserId,
      required this.receiverUserId,
      required this.sentOn});
}
