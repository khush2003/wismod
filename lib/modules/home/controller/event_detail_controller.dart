import 'package:get/get.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';

class EventDetailController extends GetxController {
  final firestore = FirebaseService();
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;

  @override
  void onReady() async {
    fetchEvent();
    // final eventData = Event(
    //   description:
    //       'Welcome, come, join, have fuuuuuuuuuuunnunununun KMUTT is the best join me my friends we will enjoy our life and not write code.',
    //   // imageUrl:
    //   //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s',
    //   eventDate: DateTime.now(),
    //   location: 'Online',
    //   category: 'Hanging Out',
    //   eventOwner: EventOwner(
    //       name: 'Khush Agarwal',
    //       department: 'SIT',
    //       uid: '12',
    //       year: 2,
    //       userPhotoUrl:
    //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s'),
    //   id: '3',
    //   title: "Let's play a Board Game",
    //   upvotes: 400,
    //   members: [],
    // );

    // final firestore = FirebaseService();
    // await firestore.addEvent(eventData);
    // final events = await firestore.getEvents();
    // for (Event event in events) {
    //   print(event.toString());
    // }
    super.onReady();
  }

  void fetchEvent() async {
    try {
      isLoading(true);
      var eventTemp = await firestore
          .getEvent(Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI');
      print(eventTemp.toString());
      if (eventTemp != null) {
        eventData(eventTemp);
        isLoading(false);
      }
    } finally {}
  }
}
