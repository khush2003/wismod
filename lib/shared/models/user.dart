class AppUser {
  final String? uid;
  final String firstName;
  final String lastName;
  final String department;
  final String? profilePicture;
  final int year;
  final List<String>? blockedUsers;
  final List<String>? bookmarkedEvents;
  final List<String>? joinedEvents;
  final List<String>? ownedEvents;
  final List<String>? requestedEvents;
  final List<String>? upvotedEvents;

  AppUser(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.department,
      this.profilePicture,
      required this.year,
      this.blockedUsers,
      this.bookmarkedEvents,
      this.joinedEvents,
      this.ownedEvents,
      this.requestedEvents,
      this.upvotedEvents});
  @override
  String toString() {
    return 'AppUser{uid: $uid, firstName: $firstName, lastName: $lastName, department: $department, '
        'profilePicture: $profilePicture, year: $year, blockedUsers: $blockedUsers, '
        'bookmarkedEvents: $bookmarkedEvents, joinedEvents: $joinedEvents, ownedEvents: $ownedEvents, '
        'requestedEvents: $requestedEvents, upvotedEvents: $upvotedEvents}';
  }

  factory AppUser.empty() {
    return AppUser(firstName: '', lastName: '', department: '', year: 0);
  }

  factory AppUser.fromMap(Map<String, dynamic> map, String userId) {
    return AppUser(
      uid: userId,
      firstName: map['Firstname'],
      lastName: map['Lastname'],
      department: map['Department'],
      profilePicture: map['ProfilePicture'],
      year: map['Year'] as int,
      blockedUsers: List<String>.from(map['BlockedUsers'] ?? []),
      bookmarkedEvents: List<String>.from(map['BookmarkedEevnts'] ?? []),
      joinedEvents: List<String>.from(map['JoinedEvents'] ?? []),
      ownedEvents: List<String>.from(map['OwnedEvents'] ?? []),
      requestedEvents: List<String>.from(map['RequestedEvents'] ?? []),
      upvotedEvents: List<String>.from(map['UpvotedEvents'] ?? []),
    );
  }
}
