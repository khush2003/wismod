import 'package:get/get.dart';
import 'package:wismod/shared/models/event.dart';

class EventDetailController extends GetxController {
  final Rx<Event> eventData = Event(
    loacation: '',
    description: 'Loading.',
    imageUrl: '',
    eventDate: DateTime.now(),
    category: 'Loading',
    eventOwner:
        EventOwner(name: 'Loading', department: 'Loading', uid: '1', year: 0),
    id: 0,
    title: "Loading",
    upvotes: 0,
  ).obs;
  final isLoading = true.obs;

  @override
  void onReady() async {
    fetchEvent();
    super.onReady();
  }

  void fetchEvent() async {
    try {
      isLoading(true);
      var eventTemp = await getData('1');
      if (eventTemp != null) {
        eventData(eventTemp);
      } else {
        // print('Error!');
      }
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  //TODO: Put this function in service file
  Future<Event>? getData(String? eventId) {
    // final int intEventId = int.parse(eventId ?? '1');
    final eventData = Event(
      description:
          'Welcome, come, join, have fuuuuuuuuuuunnunununun KMUTT is the best join me my friends we will enjoy our life and not write code.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s',
      eventDate: DateTime.now(),
      loacation: 'Online',
      category: 'Hanging Out',
      eventOwner: EventOwner(
          
          name: 'Khush Agarwal',
          department: 'SIT',
          uid: '12',
          year: 2,
          userPhotoUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s'),
      id: 3,
      title: "Let's play a Board Game",
      upvotes: 400,
      totalCapacity: 20,
      numJoined: 1,
    );
    return Future.delayed(const Duration(seconds: 1), () => eventData);
  }
}
