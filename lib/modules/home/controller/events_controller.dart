import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/user.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

class EventsController extends GetxController {
  static EventsController get instance => Get.find();
  final events = <Event>[].obs;
  final joinedEvents = <Event>[].obs;
  final RxList<Event> ownedEvents = <Event>[].obs;
  final RxList<Event> bookmarkedEvents = <Event>[].obs;
  final RxList<Event> requestedEvents = <Event>[].obs;
  final RxList<Event> upvotedEvents = <Event>[].obs;
  final RxList<Event> reportedEvents = <Event>[].obs;

  final _firestore = FirebaseService();
  final _auth = AuthController.instance;

  final isInitialized = false.obs;

  @override
  void onInit() async {
    await fetchEvents();
    initializeLists();
    isInitialized(true);
    super.onInit();
  }

  void initializeLists() {
    final user = _auth.appUser.value;
    _setOwnedEvents(user);
    _setBookmarkedEvents(user);
    _setRequestedEvents(user);
    _setUpvotedEvents(user);
    _setReportedEvents(user);
    _setJoinedEvents(user);
  }

  Future<void> fetchEvents() async {
    try {
      final eventsTemp = await _firestore.getEvents();
      if (eventsTemp.isNotEmpty) {
        events(eventsTemp);
      }
    } finally {}
  }

  void _setOwnedEvents(AppUser user) {
    if (events.isNotEmpty) {
      ownedEvents.clear();
      ownedEvents
          .addAll(events.where((event) => event.eventOwner.uid == user.uid));
    }
  }

  void _setBookmarkedEvents(AppUser user) {
    bookmarkedEvents.clear();
    final tempBookmarkedEvents = user.bookmarkedEvents;
    if (tempBookmarkedEvents != null && tempBookmarkedEvents.isNotEmpty) {
      bookmarkedEvents.addAll(
          events.where((event) => tempBookmarkedEvents.contains(event.id)));
    }
  }


  void _setRequestedEvents(AppUser user) {
    requestedEvents.clear();
    final tempRequestedEvents = user.requestedEvents;
    if (tempRequestedEvents != null && tempRequestedEvents.isNotEmpty) {
      requestedEvents.addAll(
          events.where((event) => tempRequestedEvents.contains(event.id)));
    }
  }

  void _setUpvotedEvents(AppUser user) {
    upvotedEvents.clear();
    final tempUpvotedEvents = user.upvotedEvents;
    if (tempUpvotedEvents != null && tempUpvotedEvents.isNotEmpty) {
      upvotedEvents.addAll(
          events.where((event) => tempUpvotedEvents.contains(event.id)));
    }
  }

  void _setReportedEvents(AppUser user) {
    reportedEvents.clear();
    reportedEvents.addAll(events.where((event) => event.isReported == true));
  }

  void _setJoinedEvents(AppUser user) {
    joinedEvents.clear();
    final tempJoinedEvents = user.joinedEvents;
    if (tempJoinedEvents != null && tempJoinedEvents.isNotEmpty) {
      joinedEvents
          .addAll(events.where((event) => tempJoinedEvents.contains(event.id)));
    }
  }

  void upvoteEvent(Event eventData) async {
    final event = getEventInList(eventData.id!, events);
    if (event == null) {
      return;
    }
    var isAdd = true;
    if (checkEventInList(event.id!, upvotedEvents)) {
      isAdd = false;
      upvotedEvents.removeWhere((e) => e.id == event.id);
      events[getIndexOfEvent(event, events)].upvotes -= 1;
      _auth.appUser.value.upvotedEvents?.remove(event.id!);
    } else {
      upvotedEvents.add(event);
      events[getIndexOfEvent(event, events)].upvotes += 1;
      _auth.appUser.value.upvotedEvents?.add(event.id!);
    }
    await _firestore.upvoteEvent(_auth.user.uid!, event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      if (isAdd) {
        upvotedEvents.removeWhere((e) => e.id == event.id);
        events[getIndexOfEvent(event, events)].upvotes -= 1;
        _auth.appUser.value.upvotedEvents?.remove(event.id!);
      } else {
        upvotedEvents.add(event);
        events[getIndexOfEvent(event, events)].upvotes += 1;
        _auth.appUser.value.upvotedEvents?.add(event.id!);
      }
    });
  }

  void joinEvent(Event eventData) async {
    final event = getEventInList(eventData.id!, events);
    if (event == null) {
      return;
    }
    var isAdd = true;
    if (checkEventInList(event.id!, joinedEvents)) {
      isAdd = false;
      joinedEvents.removeWhere((e) => e.id == event.id);
      _auth.appUser.value.joinedEvents?.remove(event.id!);
      events[getIndexOfEvent(event, events)].members!.remove(_auth.user.uid!);
    } else {
      joinedEvents.add(event);
      _auth.appUser.value.joinedEvents?.add(event.id!);
      events[getIndexOfEvent(event, events)].members!.add(_auth.user.uid!);
    }
    await _firestore.joinEvent(_auth.user.uid!, event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      if (isAdd) {
        joinedEvents.removeWhere((e) => e.id == event.id);
        _auth.appUser.value.joinedEvents?.remove(event.id!);
        events[getIndexOfEvent(event, events)].members!.remove(_auth.user.uid!);
      } else {
        joinedEvents.add(event);
        _auth.appUser.value.joinedEvents?.add(event.id!);
        events[getIndexOfEvent(event, events)].members!.add(_auth.user.uid!);
      }
    });
  }

  void bookmarkEvent(Event eventData) async {
    final event = getEventInList(eventData.id!, events);
    if (event == null) {
      return;
    }
    var isAdd = true;
    if (checkEventInList(event.id!, bookmarkedEvents)) {
      isAdd = false;
      bookmarkedEvents.removeWhere((e) => e.id == event.id);
      _auth.appUser.value.bookmarkedEvents?.remove(event.id!);
    } else {
      bookmarkedEvents.add(event);
      _auth.appUser.value.bookmarkedEvents?.add(event.id!);
    }
    await _firestore.bookmarkEvent(_auth.user.uid!, event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      if (isAdd) {
        bookmarkedEvents.removeWhere((e) => e.id == event.id);
        _auth.appUser.value.bookmarkedEvents?.remove(event.id!);
      } else {
        bookmarkedEvents.add(event);
        _auth.appUser.value.bookmarkedEvents?.add(event.id!);
      }
    }).then((value) => sucessSnackBar("Done"));
  }

  void reportEvent(Event eventData) async {
    final event = getEventInList(eventData.id!, events);
    if (event == null) {
      return;
    }
    events[getIndexOfEvent(event, events)].isReported = true;
    reportedEvents.add(event);
    await _firestore.reportEvent(event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      events[getIndexOfEvent(event, events)].isReported = false;
    }).then((value) => sucessSnackBar("Reported Sucessfully!"));
  }

  void reportEventDeny(Event event) async {
    events[getIndexOfEvent(event, events)].isReported = false;
    reportedEvents.removeWhere((e) => e.id == event.id);
    await _firestore.reportEventDeny(event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      events[getIndexOfEvent(event, events)].isReported = true;
      reportedEvents.add(event);
    }).then((value) => sucessSnackBar("Reported Sucessfully!"));
  }
}
