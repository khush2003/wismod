class AppUser {
  final String? uid;
  final String firstName;
  final String lastName;
  final String department;
  final String? profilePicture;
  final int year;
  final bool? isAdmin;
  final List<String>? blockedChatGroups;
  final List<String>? bookmarkedEvents;
  final List<String>? joinedEvents;
  final List<String>? ownedEvents;
  final List<String>? requestedEvents;
  final List<String>? upvotedEvents;
  final List<String>? joinedChatGroups;
  final String? token;

  AppUser( {
    this.token,
    this.uid,
    this.isAdmin,
    required this.firstName,
    required this.lastName,
    required this.department,
    this.profilePicture,
    required this.year,
    this.blockedChatGroups,
    this.bookmarkedEvents,
    this.joinedEvents,
    this.ownedEvents,
    this.requestedEvents,
    this.upvotedEvents,
    this.joinedChatGroups,
  });
  @override
  String toString() {
    return 'AppUser{uid: $uid, '
        // 'firstName: $firstName, lastName: $lastName, department: $department, '
        //     'profilePicture: $profilePicture, year: $year, blockedChatGroups: $blockedChatGroups, '
        //     'bookmarkedEvents: $bookmarkedEvents, joinedEvents: $joinedEvents, ownedEvents: $ownedEvents, '
        //     'requestedEvents: $requestedEvents, upvotedEvents: $upvotedEvents, joinedChatGroups: $joinedChatGroups, isAdmin: $isAdmin'
        '}';
  }

  factory AppUser.empty() {
    return AppUser(firstName: '', lastName: '', department: '', year: 0);
  }

  String getName() {
    return '$firstName $lastName';
  }

  List<String> getJoinedChatGroups() {
    List<String> eventIds = [];
    if (joinedChatGroups != null && joinedChatGroups!.isNotEmpty) {
      for (String eventId in joinedChatGroups!) {
        eventIds.add(eventId);
      }
    }
    return eventIds;
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String userId) {
    return AppUser(
      token: map['Token'] ?? '',
      isAdmin: map['IsAdmin'] ?? false,
      uid: userId,
      firstName: map['Firstname'],
      lastName: map['Lastname'],
      department: map['Department'],
      profilePicture: map['ProfilePicture'],
      year: map['Year'] as int,
      blockedChatGroups: List<String>.from(map['BlockedChatGroups'] ?? []),
      bookmarkedEvents: List<String>.from(map['BookmarkedEvents'] ?? []),
      joinedEvents: List<String>.from(map['JoinedEvents'] ?? []),
      ownedEvents: List<String>.from(map['OwnedEvents'] ?? []),
      requestedEvents: List<String>.from(map['RequestedEvents'] ?? []),
      upvotedEvents: List<String>.from(map['UpvotedEvents'] ?? []),
      joinedChatGroups: List<String>.from(map['JoinedChatGroups'] ?? []),
    );
  }
}

bool checkUserInList(String userId, List<AppUser> list) {
  return list.any((user) => user.uid == userId);
}

AppUser? getUserInList(String userId, List<AppUser> list) {
  try {
    return list.where((user) => user.uid == userId).first;
  } catch (e) {
    return null;
  }
}
