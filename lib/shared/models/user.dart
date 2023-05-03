class AppUser {
  final String? uid;
  final String firstName;
  final String lastName;
  final String department;
  final String profilePicture;
  final int year;
  final List<String>? blockedUsers;
  final List<String>? bookmarkedEevnts;
  final List<String>? joinedEvents;
  final List<String>? ownedEvents;
  final List<String>? requestedEvents;
  final List<String>? upvotedEvents;

  AppUser(
      { this.uid,
      required this.firstName,
      required this.lastName,
      required this.department,
      required this.profilePicture,
      required this.year,
      this.blockedUsers,
      this.bookmarkedEevnts,
      this.joinedEvents,
      this.ownedEvents,
      this.requestedEvents,
      this.upvotedEvents});
}
