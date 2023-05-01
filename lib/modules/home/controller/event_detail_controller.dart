import 'package:get/get.dart';
import 'package:wismod/shared/models/event.dart';

class EventDetailController extends GetxController {
  late Rx<Event> eventData;
  @override
  void onInit() async {
    eventData(await getData(Get.parameters['id']));
    super.onInit();
  }

  Future<Event> getData(String? eventId) {
    // final int intEventId = int.parse(eventId ?? '1');
    final eventData = Event(
      description:
          'Welcome, come, join, have fuuuuuuuuuuunnunununun KMUTT is the best join me my friends we will enjoy our life and not write code.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s',
      eventDate: DateTime.now(),
      category: 'Hanging Out',
      eventOwner: 'Khush Agarwal',
      id: 3,
      title: "Let's play a Board Game",
      upvotes: 400,
    );
    return Future.delayed(const Duration(seconds: 1),() => eventData);
  }
}
