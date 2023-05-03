import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wismod/shared/models/user.dart';
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

  Future<List<String>?> getDepartments() async {
    final document = _firestore.collection('AppData').doc('AppData');
    final snapshot = await document.get();

    if (!snapshot.exists) {
      return null;
    }
    final data = snapshot.data();
    return List<String>.from(data!['Departments'] as List<dynamic>);
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

  Future<AppUser?> getUserById(String userId) async {
    final docSnapshot = await _firestore.collection('Users').doc(userId).get();
    if (docSnapshot.exists) {
      final userData = docSnapshot.data();
      if (userData != null) {
        return AppUser.fromMap(userData, userId);
      }
      return null;
    }
    return null;
  }

  Future<void> addEvent(Event event) async {
    await _firestore.collection('Events').add({
      'Title': event.title,
      'Category': event.category,
      'Upvotes': event.upvotes,
      'ImageURL': event.imageUrl,
      'EventDate':
          event.eventDate == null ? null : Timestamp.fromDate(event.eventDate!),
      'EventOwnerName': event.eventOwner.name,
      'EventOwnerDepartment': event.eventOwner.department,
      'EventOwnerYear': event.eventOwner.year,
      'EventOwnerId': event.eventOwner.uid,
      'Description': event.description,
      'TotalCapacity': event.totalCapacity,
      'AllowAutomaticJoin': event.allowAutomaticJoin,
      'Members': event.members,
      'Location': event.location,
      'Tags': event.tags,
      'IsReported': event.isReported,
      'CreatedAt': event.createdAt == null
          ? Timestamp.now()
          : Timestamp.fromDate(event.createdAt!)
    });
    await _addTagsToTagData(event);
  }

  Future<void> addUser(AppUser user) async {
    await _firestore.collection('Users').doc(user.uid).set({
      'Firstname': user.firstName,
      'Lastname': user.lastName,
      'Department': user.department,
      'ProfilePicture': user.profilePicture,
      'Year': user.year,
      'BlockedUsers': user.blockedUsers ?? [],
      'BookmarkedEevnts': user.bookmarkedEvents ?? [],
      'JoinedEvents': user.joinedEvents ?? [],
      'OwnedEvents': user.ownedEvents ?? [],
      'RequestedEvents': user.requestedEvents ?? [],
      'UpvotedEvents': user.upvotedEvents ?? [],
      'IsAdmin': user.isAdmin ?? false
    });
  }

  Future<void> _addTagsToTagData(Event event) async {
    if (event.tags != null) {
      var tags = [];
      final documentAppData = _firestore.collection('AppData').doc('AppData');
      await documentAppData.get().then((doc) {
        if (doc.exists) {
          tags = doc['Tags'] != null
              ? List<String>.from(doc['Tags'] as List<dynamic>)
              : <String>[]; // Handle the case where tags is null or undefined.
          for (String tag in event.tags!) {
            if (!tags.contains(tag)) {
              tags.add(tag);
            }
          }
        }
      });
      await _firestore.collection('AppData').doc('AppData').update({
        'Tags': tags,
      });
    }
  }
}
