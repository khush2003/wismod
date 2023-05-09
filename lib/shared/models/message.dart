import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class Message {
  final String message;
  final String userId;
  final String? imageUrl;
  final DateTime? sentOn;
  final String? eventId;

  Message({
    required this.message,
    required this.userId,
    this.imageUrl,
    this.sentOn,
    this.eventId,
  });
  @override
  String toString() {
    return 'Message {'
        'id: $userId,'
        'imageUrl: $imageUrl,'
        'message: $message,'
        'date: $sentOn'
        'event: $eventId'
        '}';
  }

  factory Message.empty() {
    return Message(
      message: '',
      userId: '1',
    );
  }

  factory Message.fromMap(Map<String, dynamic> map, String messageText) {
    final time = map['sentOn'] as Timestamp;
    return Message(
      message: messageText,
      userId: map['UserId'] as String,
      imageUrl: map['ImageUrl'] as String,
      sentOn: time.toDate(),
      eventId: map['EventId'] as String,
    );
  }
}
