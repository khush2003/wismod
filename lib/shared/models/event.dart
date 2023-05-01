class Event {
  final String category;
  final String title;
  final int upvotes;
  final String? imageUrl;
  final DateTime? eventDate;
  final String eventOwner;
  final String? description;
  final int id;

  Event(
      {required this.category,
      required this.title,
      required this.upvotes,
      this.imageUrl,
      this.eventDate,
      required this.eventOwner,
      this.description,
      required this.id});
}
