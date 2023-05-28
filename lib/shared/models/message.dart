import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final String message;
  final String sentBy;
  String userName;
  final String? profilePicture;
  final DateTime? sentOn;
  final String? eventId;

  Message({
    this.id,
    required this.message,
    required this.sentBy,
    this.sentOn,
    this.eventId,
    required this.userName,
    this.profilePicture,
  });
  @override
  String toString() {
    return 'Message {'
        'id: $sentBy,'
        'message: $message,'
        'date: $sentOn'
        'event: $eventId'
        'userName : $userName'
        'profilePicture : $profilePicture'
        '}';
  }

  factory Message.empty() {
    return Message(
      message: '',
      sentBy: '',
      profilePicture: '',
      userName: '',
    );
  }

  factory Message.fromMap(Map<String, dynamic> map, String messageId) {
    final time = map['SentOn'] as Timestamp;
    return Message(
      id: messageId,
      message: map['Message'] as String,
      sentBy: map['SentBy'] as String,
      sentOn: time.toDate(),
      eventId: map['EventId'] as String,
      profilePicture: map['ProfilePicture'] as String?,
      userName: map['UserName'] as String,
    );
  }
}
