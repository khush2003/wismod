class Event {
  final String category;
  final String title;
  final int upvotes;
  final String? imageUrl;
  final DateTime? eventDate;
  final EventOwner eventOwner;
  final String? description;
  final int id;
  final int? totalCapacity;
  final int? numJoined;
   final String loacation;

  Event({
    required this.loacation,
    required this.category,
    required this.title,
    required this.upvotes,
    this.imageUrl,
    this.eventDate,
    required this.eventOwner,
    this.description,
    required this.id,
    this.totalCapacity,
    this.numJoined,
  });
}

class EventOwner {
  final String? userPhotoUrl;
  final String name;
  final String department;
  final int year;
  final String uid;
  EventOwner(
      {this.userPhotoUrl,
      
      required this.name,
      required this.department,
      required this.year,
      required this.uid});
}
