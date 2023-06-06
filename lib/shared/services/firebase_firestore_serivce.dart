import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/models/user.dart';
import '../models/event.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> getAllEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Events').get();
    List<Event> events = [];
    for (var doc in snapshot.docs) {
      Event event = Event.fromMap(doc.data(), doc.id);
      events.add(event);
    }
    return events;
  }

  Future<List<AppUser>> getRequestedUsers(String eventId) async {
    List<AppUser> allUsers = await getAllUsers();
    List<AppUser> requestedUsers = [];
    for (var user in allUsers) {
      if (user.requestedEvents != null &&
          user.requestedEvents!.contains(eventId)) {
        requestedUsers.add(user);
      }
    }
    return requestedUsers;
  }

  Future<List<AppUser>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Users').get();
    List<AppUser> users = [];
    for (var doc in snapshot.docs) {
      AppUser user = AppUser.fromMap(doc.data(), doc.id);
      users.add(user);
    }
    return users;
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

  Future<void> deleteMemberFromEvent(String eventId, String userId) {
    final eventRef = _firestore.collection('Events').doc(eventId);
    return eventRef.update({
      'Members': FieldValue.arrayRemove([userId])
    });
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
    return Message.fromMap(data, latestMessage.id);
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
      return Message.fromMap(data, doc.id);
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

  Stream<List<Message>> getMessagesStream(String eventId) {
    return FirebaseFirestore.instance
        .collection('Messages')
        .where('EventId', isEqualTo: eventId)
        .orderBy('SentOn', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            return Message.fromMap(data, doc.id);
          })
          .toList()
          .reversed
          .toList();
    });
  }

  Stream<Message?> getLatestMessagesStream(String eventId) {
    return FirebaseFirestore.instance
        .collection('Messages')
        .where('EventId', isEqualTo: eventId)
        .orderBy('SentOn', descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs[0].data();
        return Message.fromMap(data, querySnapshot.docs[0].id);
      } else {
        return null;
      }
    });
  }

  Stream<List<Event>> getEventsStream() {
    return FirebaseFirestore.instance
        .collection('Events')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Event.fromMap(data, doc.id);
      }).toList();
    });
  }

  Stream<AppUser> getUserStream(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.data() != null) {
        return AppUser.fromMap(docSnapshot.data()!, userId);
      } else {
        return AppUser.empty(); // or return an appropriate default value
      }
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

  Future<void> approveJoin(AppUser user, Event event) async {
    final documentUsers = _firestore.collection('Users').doc(user.uid!);
    final documentEvents = _firestore.collection('Events').doc(event.id);
    var members = <String>[];
    var upvotes = 0;
    var joinedEvents = <String>[];
    var requestedEvents = <String>[];
    await documentUsers.get().then((doc) {
      if (doc.exists) {
        joinedEvents = doc['JoinedEvents'] != null
            ? List<String>.from(doc['JoinedEvents'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        requestedEvents = doc['RequestedEvents'] != null
            ? List<String>.from(doc['RequestedEvents'] as List<dynamic>)
            : <String>[];
        if (!joinedEvents.contains(event.id)) {
          joinedEvents.add(event.id!);
          if (requestedEvents.contains(event.id)) {
            requestedEvents.remove(event.id!);
          }
        } else {
          throw Exception('Event joined already!');
        }
      } else {
        throw Exception('User does not exist!');
      }
    });
    await documentEvents.get().then((doc) {
      if (doc.exists) {
        upvotes = doc['Upvotes'] as int;
        members = doc['Members'] != null
            ? List<String>.from(doc['Members'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        if (!members.contains(user.uid!)) {
          members.add(user.uid!);
        } else {
          throw Exception('Event joined already!');
        }
      } else {
        throw Exception('Event does not exist!');
      }
    });
    await _firestore.collection('Users').doc(user.uid!).update(
        {'JoinedEvents': joinedEvents, 'RequestedEvents': requestedEvents});
    await _firestore
        .collection('Events')
        .doc(event.id)
        .update({'Members': members, 'Upvotes': upvotes});
  }

  Future<void> denyJoin(AppUser user, Event event) async {
    final documentUsers = _firestore.collection('Users').doc(user.uid!);
    var requestedEvents = <String>[];
    await documentUsers.get().then((doc) {
      if (doc.exists) {
        requestedEvents = doc['RequestedEvents'] != null
            ? List<String>.from(doc['RequestedEvents'] as List<dynamic>)
            : <String>[];
        if (requestedEvents.contains(event.id)) {
          requestedEvents.remove(event.id!);
        } else {
          throw Exception('Event not requested or joined already!');
        }
      } else {
        throw Exception('User does not exist!');
      }
    });
    await _firestore
        .collection('Users')
        .doc(user.uid!)
        .update({'RequestedEvents': requestedEvents});
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
    final eventId = doc.id;
    try {
      await joinChatGroup(user.uid!, eventId);
    } on Exception catch (_) {
      throw Exception('User is not logged in or event id is not provided');
    }
  }

  Future<void> editEvent(Event event) async {
    final doc = await _firestore.collection('Events').doc(event.id).get();
    if (!doc.exists) {
      throw Exception('Event does not exist');
    }

    await _firestore.collection('Events').doc(event.id).update({
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
      'Token': user.token ?? '',
      'BlockedChatGroups': user.blockedChatGroups ?? [],
      'BookmarkedEvents': user.bookmarkedEvents ?? [],
      'JoinedEvents': user.joinedEvents ?? [],
      'OwnedEvents': user.ownedEvents ?? [],
      'RequestedEvents': user.requestedEvents ?? [],
      'UpvotedEvents': user.upvotedEvents ?? [],
      'IsAdmin': user.isAdmin ?? false,
      'JoinedChatGroups': user.joinedChatGroups ?? [],
    });
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

  Future<void> reportEventDeny(String eventId) async {
    final eventDocument = _firestore.collection('Events').doc(eventId);
    final eventSnapshot = await eventDocument.get();

    if (!eventSnapshot.exists) {
      throw Exception('Event does not exist!');
    }

    final event = Event.fromMap(eventSnapshot.data()!, eventSnapshot.id);
    if (event.isReported == false) {
      return;
    }

    await eventDocument.update({'IsReported': false});
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

  Future<void> updateUserName(
      String firstName, String lastName, String userId) async {
    final events = await getAllEvents();
    final user =
        await getUserById(userId) ?? AuthController.instance.appUser.value;

    for (Event event in events) {
      if (event.eventOwner.uid == userId) {
        // Update eventOwnerName
        event.eventOwner.name = '$firstName $lastName';
        await _firestore.collection('Events').doc(event.id).update({
          'EventOwnerName': event.eventOwner.name,
        });
      }
    }

    for (String eventId in user.joinedChatGroups ?? []) {
      final messages = await getMessages(eventId);
      for (Message message in messages) {
        if (message.sentBy == userId) {
          // Update the userName for each message
          message.userName = '$firstName $lastName';
          try {
            await _firestore.collection('Messages').doc(message.id).update({
              'UserName': message.userName,
            });
          } catch (e) {
            continue;
          }
        }
      }
    }

    // Updating firstname and lastname in users
    await _firestore.collection('Users').doc(userId).update({
      'Firstname': firstName,
      'Lastname': lastName,
    });
  }

  Future<void> updateDepartment(String department, String userId) async {
    final events = await getAllEvents();

    for (Event event in events) {
      if (event.eventOwner.uid == userId) {
        // Update eventOwnerDepartment
        await _firestore.collection('Events').doc(event.id).update({
          'EventOwnerDepartment': department,
        });
      }
    }

    // Updating department in users
    await _firestore.collection('Users').doc(userId).update({
      'Department': department,
    });
  }

  Future<void> updateToken(String token, String userId) async {
    // Updating token in users
    await _firestore.collection('Users').doc(userId).set({
      'Token': token,
    });
  }

  Future<void> updateYear(int year, String userId) async {
    final events = await getAllEvents();

    for (Event event in events) {
      if (event.eventOwner.uid == userId) {
        // Update eventOwnerYear
        await _firestore.collection('Events').doc(event.id).update({
          'EventOwnerYear': year,
        });
      }
    }

    // Updating year in users
    await _firestore.collection('Users').doc(userId).update({
      'Year': year,
    });
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

  Future<void> deleteEvent(Event event) async {
    final eventDoc = _firestore.collection('Events').doc(event.id);
    final messages = await _firestore
        .collection('Messages')
        .where('EventId', isEqualTo: event.id)
        .get();

    // Delete event document and all associated messages
    final batch = _firestore.batch();
    batch.delete(eventDoc);
    for (final messageDoc in messages.docs) {
      batch.delete(messageDoc.reference);
    }
    await batch.commit();

    // Update user documents to remove references to the event
    final users = await _firestore.collection('Users').get();
    final userBatches = <WriteBatch>[];
    for (final userDoc in users.docs) {
      final userData = userDoc.data();
      final joinedEvents =
          List<String>.from(userData['JoinedEvents'] ?? <String>[]);
      final requestedEvents =
          List<String>.from(userData['RequestedEvents'] ?? <String>[]);
      final ownedEvents =
          List<String>.from(userData['OwnedEvents'] ?? <String>[]);
      final bookmarkedEvents =
          List<String>.from(userData['BookmarkedEvents'] ?? <String>[]);
      final upvotedEvents =
          List<String>.from(userData['UpvotedEvents'] ?? <String>[]);
      final blockedChatGroups =
          List<String>.from(userData['BlockedChatGroups'] ?? <String>[]);
      final joinedChatGroups =
          List<String>.from(userData['JoinedChatGroups'] ?? <String>[]);

      if (joinedEvents.remove(event.id)) {
        userDoc.reference.update({'JoinedEvents': joinedEvents});
      }
      if (requestedEvents.remove(event.id)) {
        userDoc.reference.update({'RequestedEvents': requestedEvents});
      }
      if (ownedEvents.remove(event.id)) {
        userDoc.reference.update({'OwnedEvents': ownedEvents});
      }
      if (bookmarkedEvents.remove(event.id)) {
        userDoc.reference.update({'BookmarkedEvents': bookmarkedEvents});
      }
      if (upvotedEvents.remove(event.id)) {
        userDoc.reference.update({'UpvotedEvents': upvotedEvents});
      }
      if (blockedChatGroups.remove(event.id)) {
        userDoc.reference.update({'BlockedChatGroups': blockedChatGroups});
      }
      if (joinedChatGroups.remove(event.id)) {
        userDoc.reference.update({'JoinedChatGroups': joinedChatGroups});
      }

      if (joinedEvents.isNotEmpty ||
          requestedEvents.isNotEmpty ||
          ownedEvents.isNotEmpty ||
          bookmarkedEvents.isNotEmpty ||
          upvotedEvents.isNotEmpty ||
          blockedChatGroups.isNotEmpty ||
          joinedChatGroups.isNotEmpty) {
        final batch = _firestore.batch();
        batch.update(userDoc.reference, {
          'JoinedEvents': joinedEvents,
          'RequestedEvents': requestedEvents,
          'OwnedEvents': ownedEvents,
          'BookmarkedEvents': bookmarkedEvents,
          'UpvotedEvents': upvotedEvents,
          'BlockedChatGroups': blockedChatGroups,
          'JoinedChatGroups': joinedChatGroups,
        });
        userBatches.add(batch);
      }
    }
    await Future.wait(userBatches.map((batch) => batch.commit()));
  }

  Future<void> requestEvent(String userId, String eventId) async {
    final documentUsers = _firestore.collection('Users').doc(userId);
    var requestedEvents = <String>[];
    final documentEvents = _firestore.collection('Events').doc(eventId);

    var updated = false;

    await documentEvents.get().then((doc) {
      if (doc.exists) {
        try {
           updated = doc['Updated'] as bool? ??
            false; // Handle the case where upvotes is null or undefined.
        } catch (_){
          updated = false;
        }
       
      } else {
        throw Exception('Event does not exist!');
      }
    });

    updated = !updated;

    await documentUsers.get().then((doc) {
      if (doc.exists) {
        requestedEvents = doc['RequestedEvents'] != null
            ? List<String>.from(doc['RequestedEvents'] as List<dynamic>)
            : <String>[]; // Handle the case where tags is null or undefined.
        if (!requestedEvents.contains(eventId)) {
          requestedEvents.add(eventId);
        } else {
          throw Exception('Event requested already!');
        }
      } else {
        throw Exception('User does not exist!');
      }
    });
    await _firestore
        .collection('Users')
        .doc(userId)
        .update({'RequestedEvents': requestedEvents});
    await _firestore
        .collection('Events')
        .doc(eventId)
        .update({'Updated': updated});
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

  Future<void> blockChatGroup(String userId, String eventId) async {
    final userRef = _firestore.collection('Users').doc(userId);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw Exception('User does not exist!');
    }

    final user = AppUser.fromMap(userDoc.data()!, userId);
    final blockedChatGroups = user.blockedChatGroups ?? [];

    if (blockedChatGroups.contains(eventId)) {
      return; // Event already blocked
    }

    final updatedBlockedChatGroups = [...blockedChatGroups, eventId];
    await userRef.update({'BlockedChatGroups': updatedBlockedChatGroups});
  }

  Future<void> unblockChatGroup(String userId, String eventId) async {
    final userRef = _firestore.collection('Users').doc(userId);
    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw Exception('User does not exist!');
    }

    final user = AppUser.fromMap(userDoc.data()!, userId);
    final blockedChatGroups = user.blockedChatGroups ?? [];

    if (!blockedChatGroups.contains(eventId)) {
      return; // Event not blocked
    }

    final updatedBlockedChatGroups =
        blockedChatGroups.where((id) => id != eventId).toList();
    await userRef.update({'BlockedChatGroups': updatedBlockedChatGroups});
  }

  Future<List<Event>> getBlockedChatGroups(String userId) async {
    final user = await getUserById(userId);
    final events = await getAllEvents();
    if (user != null) {
      final blockedEvents = events
          .where((event) => user.blockedChatGroups?.contains(event.id) ?? false)
          .toList();
      return blockedEvents;
    } else {
      throw Exception('User does not exists!');
    }
  }
  // Add functions here
}
