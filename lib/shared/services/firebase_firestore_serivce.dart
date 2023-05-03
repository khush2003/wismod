import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> getEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Events').get();
    List<Event> events = [];
    for (var doc in snapshot.docs) {
      Event event = Event.fromMap(doc.data(), doc.id);
      events.add(event);
    }
    return events;
  }

  Future<List<String>?> getCategories() async {
    final document = _firestore.collection('AppData').doc('AppData');
    final snapshot = await document.get();

    if (!snapshot.exists) {
      return null;
    }
    final data = snapshot.data();
    return List<String>.from(data!['Categories'] as List<dynamic>);
  }

  Future<Event?> getEvent(String eventId) async {
    final document = _firestore.collection('Events').doc(eventId);
    final snapshot = await document.get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();
    if (data == null) {
      return null;
    }

    return Event.fromMap(data, eventId);
  }

  Future<void> addEvent(Event event) async {
    try {
      await _firestore.collection('Events').add({
        'Title': event.title,
        'Category': event.category,
        'Upvotes': event.upvotes,
        'ImageURL': event.imageUrl,
        'EventDate': event.eventDate == null
            ? null
            : Timestamp.fromDate(event.eventDate!),
        'EventOwnerName': event.eventOwner.name,
        'EventOwnerDepartment': event.eventOwner.department,
        'EventOwnerYear': event.eventOwner.year,
        'EventOwnerId': event.eventOwner.uid,
        'Description': event.description,
        'TotalCapacity': event.totalCapacity,
        'Members': event.members,
        'Location': event.location,
        'Tags': event.tags,
        'IsReported': event.isReported,
      });

      // throw Exception('Missing required fields');
    } catch (e) {
      throw Exception(e);
    }
  }
}
