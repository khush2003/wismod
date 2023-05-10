import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wismod/shared/models/message.dart';
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

  Future<Message?> getLatestMessage(String eventId) async {
    final querySnapshot = await _firestore
        .collection('Messages')
        .where('EventId', isEqualTo: eventId)
        .orderBy('SentOn', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.size == 0) {
      return null; // No messages found
    }

    final latestMessage = querySnapshot.docs.first;
    final data = latestMessage.data();
    return Message.fromMap(data);
  }

  Future<List<Message>> getMessages(String eventId) async {
    final querySnapshot = await _firestore
        .collection('Messages')
        .where('EventId', isEqualTo: eventId)
        .orderBy('SentOn', descending: true)
        .get();

    if (querySnapshot.size == 0) {
      return <Message>[]; // No messages found
    }

    final messages = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Message.fromMap(data);
    }).toList();

    return messages.reversed.toList();
  }

  Future<void> addMessage(Message message) async {
    await _firestore.collection('Messages').add({
      'Message': message.message,
      'SentBy': message.sentBy,
      'SentOn': message.sentOn == null
          ? Timestamp.now()
          : Timestamp.fromDate(message.sentOn!),
      'EventId': message.eventId,
      'UserName': message.userName,
      'ProfilePicture': message.profilePicture ?? '',
    });
  }

  Future<void> updateProfilePicture(String userId, String imagePath) async {
    // Update the user's profile picture in Firestore
    await _firestore.collection('Users').doc(userId).update({
      'ProfilePicture': imagePath,
    });
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

  Future<void> addEvent(Event event, AppUser user) async {
    final doc = await _firestore.collection('Events').add({
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
          : Timestamp.fromDate(event.createdAt!),
    });
    await _addTagsToTagData(event);
    final eventId = doc.id;
    try {
      await joinChatGroup(user.uid!, eventId);
    } on Exception catch (_) {
      throw Exception('User is not logged in or event id is not provided');
    }
  }

  /// Fixes the chat group join for all users by adding them to the chat group
  /// of the event they own.
  /// This method iterates over all events and checks the owner of each event.
  /// If the owner exists and has not already joined the chat group of the event,
  /// the owner is added to the chat group.
  /// This ensures that event owners are included in the chat group of their events.
  Future<void> fixChatGroupJoin() async {
    final eventsSnapshot = await _firestore.collection('Events').get();
    final events = eventsSnapshot.docs;

    for (var eventDoc in events) {
      final event = Event.fromMap(eventDoc.data(), eventDoc.id);
      final ownerId = event.eventOwner.uid;

      // Check if the user exists
      final ownerDoc = await _firestore.collection('Users').doc(ownerId).get();
      if (!ownerDoc.exists) {
        continue; // Skip if user doesn't exist
      }

      final user = AppUser.fromMap(ownerDoc.data()!, ownerId);
      if (user.joinedChatGroups != null &&
          user.joinedChatGroups!.contains(event.id)) {
        continue; // Skip if user already joined the chat group
      }

      final updatedJoinedChatGroups = [
        ...(user.joinedChatGroups ?? []),
        event.id
      ];
      await _firestore.collection('Users').doc(ownerId).update({
        'JoinedChatGroups': updatedJoinedChatGroups,
      });
    }
  }

  Future<void> addUser(AppUser user) async {
    await _firestore.collection('Users').doc(user.uid).set({
      'Firstname': user.firstName,
      'Lastname': user.lastName,
      'Department': user.department,
      'ProfilePicture': user.profilePicture,
      'Year': user.year,
      'BlockedUsers': user.blockedUsers ?? [],
      'BookmarkedEvents': user.bookmarkedEvents ?? [],
      'JoinedEvents': user.joinedEvents ?? [],
      'OwnedEvents': user.ownedEvents ?? [],
      'RequestedEvents': user.requestedEvents ?? [],
      'UpvotedEvents': user.upvotedEvents ?? [],
      'IsAdmin': user.isAdmin ?? false,
      'JoinedChatGroups': user.joinedChatGroups ?? [],
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

  Future<void> reportEvent(String eventId) async {
    final eventDocument = _firestore.collection('Events').doc(eventId);
    final eventSnapshot = await eventDocument.get();

    if (!eventSnapshot.exists) {
      throw Exception('Event does not exist!');
    }

    final event = Event.fromMap(eventSnapshot.data()!, eventSnapshot.id);
    if (event.isReported == true) {
      return;
    }

    await eventDocument.update({'IsReported': true});
  }

  Future<void> joinChatGroup(String userId, String eventId) async {
    final userRef = _firestore.collection('Users').doc(userId);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw Exception('User does not exist!');
    }

    final user = AppUser.fromMap(userDoc.data()!, userId);
    if (user.joinedChatGroups != null &&
        user.joinedChatGroups!.contains(eventId)) {
      return;
    }

    final updatedJoinedChatGroups = [...(user.joinedChatGroups ?? []), eventId];
    await userRef.update({'JoinedChatGroups': updatedJoinedChatGroups});
  }

  Future<void> upvoteEvent(String userId, String eventId) async {
    final documentUsers = _firestore.collection('Users').doc(userId);
    final documentEvents = _firestore.collection('Events').doc(eventId);
    var upvotedEvents = <String>[];
    var upvotes = 0;

    await documentEvents.get().then((doc) {
      if (doc.exists) {
        upvotes = doc['Upvotes']
            as int; // Handle the case where upvotes is null or undefined.
      } else {
        throw Exception('Event does not exist!');
      }
    });

    await documentUsers.get().then((doc) {
      if (doc.exists) {
        upvotedEvents = doc['UpvotedEvents'] != null
            ? List<String>.from(doc['UpvotedEvents'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        if (!upvotedEvents.contains(eventId)) {
          upvotedEvents.add(eventId);
          upvotes++;
        } else {
          upvotedEvents.remove(eventId);
          upvotes--;
        }
      } else {
        throw Exception('User does not exist!');
      }
    });
    await _firestore
        .collection('Users')
        .doc(userId)
        .update({'UpvotedEvents': upvotedEvents});
    await _firestore
        .collection('Events')
        .doc(eventId)
        .update({'Upvotes': upvotes});
  }

  Future<void> joinEvent(String userId, String eventId) async {
    final documentUsers = _firestore.collection('Users').doc(userId);
    final documentEvents = _firestore.collection('Events').doc(eventId);
    var members = <String>[];
    var joinedEvents = <String>[];
    await documentUsers.get().then((doc) {
      if (doc.exists) {
        joinedEvents = doc['JoinedEvents'] != null
            ? List<String>.from(doc['JoinedEvents'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        if (!joinedEvents.contains(eventId)) {
          joinedEvents.add(eventId);
        } else {
          throw Exception('Event joined already!');
        }
      } else {
        throw Exception('User does not exist!');
      }
    });
    await documentEvents.get().then((doc) {
      if (doc.exists) {
        members = doc['Members'] != null
            ? List<String>.from(doc['Members'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        if (!members.contains(userId)) {
          members.add(userId);
        } else {
          throw Exception('Event joined already!');
        }
      } else {
        throw Exception('Event does not exist!');
      }
    });
    await _firestore
        .collection('Users')
        .doc(userId)
        .update({'JoinedEvents': joinedEvents});
    await _firestore
        .collection('Events')
        .doc(eventId)
        .update({'Members': members});
  }

  Future<void> bookmarkEvent(String userId, String eventId) async {
    final userRef = _firestore.collection('Users').doc(userId);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw Exception('User does not exist!');
    }

    final user = AppUser.fromMap(userDoc.data()!, userId);
    final bookmarkedEvents = user.bookmarkedEvents ?? [];
    final isBookmarked = bookmarkedEvents.contains(eventId);

    List<String> updatedBookmarkedEvents;

    if (isBookmarked) {
      updatedBookmarkedEvents =
          bookmarkedEvents.where((id) => id != eventId).toList();
    } else {
      updatedBookmarkedEvents = [...bookmarkedEvents, eventId];
    }

    await userRef.update({'BookmarkedEvents': updatedBookmarkedEvents});
  }
}
