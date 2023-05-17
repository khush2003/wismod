import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String category;
  final String title;
  int upvotes;
  final String? imageUrl;
  final DateTime? eventDate;
  final EventOwner eventOwner;
  final String description;
  final String? id;
  final int? totalCapacity;
  final List<String>? members;
  final String location;
  final List<String>? tags;
  bool? isReported;
  final DateTime? createdAt;
  final bool allowAutomaticJoin;

  Event(
      {this.createdAt,
      this.members,
      this.tags,
      this.isReported,
      required this.location,
      required this.category,
      required this.title,
      required this.upvotes,
      this.imageUrl,
      this.eventDate,
      required this.eventOwner,
      required this.description,
      this.id,
      this.totalCapacity,
      this.allowAutomaticJoin = true});
  @override
  String toString() {
    return 'Event {'
        ' id: $id,'
        // ' category: $category,'
        // ' title: $title,'
        // ' upvotes: $upvotes,'
        // ' imageUrl: $imageUrl,'
        // ' eventDate: $eventDate,'
        // ' eventOwner: $eventOwner,'
        // ' description: $description,'
        // ' totalCapacity: $totalCapacity,'
        // ' members: $members,'
        // ' location: $location,'
        // ' tags: $tags,'
        // ' isReported: $isReported'
        // ' createdAt: $createdAt'
        // ' allowAutomaticJoin: $allowAutomaticJoin'
        '}';
  }

  factory Event.empty() {
    return Event(
      location: '',
      category: 'Loading',
      eventOwner:
          EventOwner(name: 'Loading', department: 'Loading', uid: '1', year: 0),
      id: '1',
      title: "Loading",
      upvotes: 0,
      description: '',
    );
  }
  factory Event.fromMap(Map<String, dynamic> map, String documentId) {
    final time = map['EventDate'] as Timestamp;
    final createdAt = map['CreatedAt'] as Timestamp;
    return Event(
      id: documentId,
      title: map['Title'] as String,
      category: map['Category'] as String,
      upvotes: map['Upvotes'] as int,
      imageUrl: map['ImageURL'] as String?,
      createdAt: createdAt.toDate(),
      eventDate: map['EventDate'] == null ? null : time.toDate(),
      allowAutomaticJoin: map['AllowAutomaticJoin'] as bool,
      eventOwner: EventOwner(
          department: map['EventOwnerDepartment'] as String,
          name: map['EventOwnerName'] as String,
          year: map['EventOwnerYear'] as int,
          uid: map['EventOwnerId'] as String),
      description: map['Description'] as String,
      totalCapacity: map['TotalCapacity'] as int?,
      members: map['Members'] == null
          ? null
          : List<String>.from(map['Members'] as List<dynamic>),
      location: map['Location'] as String,
      tags: map['Tags'] == null
          ? null
          : List<String>.from(map['Tags'] as List<dynamic>),
      isReported: map['IsReported'] as bool?,
    );
  }
}

bool checkEventInList(String eventId, List<Event> list) {
  return list.any((event) => event.id == eventId);
}

Event? getEventInList(String eventId, List<Event> list) {
  try {
    return list.where((event) => event.id == eventId).first;
  } catch (e) {
    return null;
  }
}

int getIndexOfEvent(Event event, List<Event> list) {
  return list.indexWhere((element) => element.id == event.id);
}

class EventOwner {
  final String? userPhotoUrl;
  String name;
  String department;
  int year;
  final String uid;
  EventOwner(
      {this.userPhotoUrl,
      required this.name,
      required this.department,
      required this.year,
      required this.uid});
}
