import 'dart:async';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/chat_controller.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
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
  final RxMap<Event, List<AppUser>> allEventJoinRequests =
      <Event, List<AppUser>>{}.obs;
  final RxMap<Event, List<AppUser>> allEventMemberList =
      <Event, List<AppUser>>{}.obs;
  final RxList<Event> requestedEvents = <Event>[].obs;
  final RxList<Event> upvotedEvents = <Event>[].obs;
  final RxList<Event> reportedEvents = <Event>[].obs;
  final RxList<Event> archivedEvents = <Event>[].obs;

  StreamSubscription<List<Event>>? eventSubscription;

  final _firestore = FirebaseService();
  final _auth = AuthController.instance;

  final Rx<bool> isInitialized = false.obs;

  @override
  void onInit() async {
    await fetchEventsStream();
    isInitialized(true);
    super.onInit();
  }

  void initializeLists() {
    final user = _auth.appUser.value;
    _setOwnedEvents(user);
    _setBookmarkedEvents(user);
    _setRequestedEvents(user);
    _setAllEventJoinRequestsAndMembers();
    _setUpvotedEvents(user);
    _setReportedEvents(user);
    _setJoinedEvents(user);
  }

  Future<List<AppUser>> getMembersfromEvent() async {
    final membersData = <AppUser>[];
    for (Event event in events) {
      event.members?.forEach((member) async {
        final memberData = await _firestore.getUserById(member);
        if (memberData != null) membersData.add(memberData);
      });
    }
    return membersData;
  }

  Future<void> fetchEventsStream() async {
    eventSubscription = _firestore.getEventsStream().listen((updatedEvents) {
      final archived = <Event>[];
      archived.addAll(updatedEvents);
      if (updatedEvents.isNotEmpty) {
        // For now removing every event whose deadline has passed, and putting them in archoived list
        final currentDate = DateTime.now();
        final today =
            DateTime(currentDate.year, currentDate.month, currentDate.day);
        updatedEvents
            .removeWhere((event) => event.eventDate?.isBefore(today) ?? false);
        archived.removeWhere(
            (event) => !(event.eventDate?.isBefore(today) ?? false));
        events(updatedEvents);
        archivedEvents(archived);
        initializeLists();
        try {
          Get.find<HomeController>().generateSmartFeed();
          Get.find<ChatController>().initializeLists();
        } catch (e) {}
      }
    });
  }

  @override
  void onClose() {
    eventSubscription
        ?.cancel(); // Cancel the subscription when closing the controller
    super.onClose();
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

  void _setAllEventJoinRequestsAndMembers() async {
    final users = await _firestore.getAllUsers();
    allEventJoinRequests.clear();
    allEventMemberList.clear();

    // Setting all event members list
    for (AppUser user in users) {
      for (String eventId in user.joinedEvents ?? []) {
        try {
          final event = events.firstWhere((element) => element.id == eventId);
          if (allEventMemberList.containsKey(event)) {
            allEventMemberList[event]!.add(user);
          } else {
            allEventMemberList[event] = [user];
          }
        } catch (e) {
          continue;
        }
      }
    }

    // for (Event event in events) {
    //   for (String userId in event.members ?? []) {
    //     if (allEventMemberList.containsKey(event)) {
    //       allEventMemberList[event]!
    //           .add(users.firstWhere((user) => user.uid == userId));
    //     } else {
    //       allEventMemberList[event] = [
    //         users.firstWhere((user) => user.uid == userId)
    //       ];
    //     }
    //   }
    // }

    // Setting all event Join Requests
    for (AppUser user in users) {
      final tempRequestedEvents = user.requestedEvents;
      if (tempRequestedEvents != null && tempRequestedEvents.isNotEmpty) {
        for (String eventId in tempRequestedEvents) {
          if (checkEventInList(eventId, ownedEvents)) {
            final event = events.firstWhere((event) => event.id == eventId);
            if (allEventJoinRequests.containsKey(event)) {
              allEventJoinRequests[event]!.add(user);
            } else {
              allEventJoinRequests[event] = [user];
            }
          }
        }
      }
    }
  }

  int getTotaLengthJoinRequests() {
    int totalCount = 0;
    for (var users in allEventJoinRequests.values) {
      totalCount += users.length;
    }
    return totalCount;
  }

  void _setRequestedEvents(AppUser user) async {
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

  void approveJoin(AppUser user, Event event) async {
    if ((event.members?.length ?? 0) < (event.totalCapacity ?? 2)) {
      requestedEvents.removeWhere((e) => e.id == event.id);
      allEventJoinRequests[event]?.removeWhere((u) => u.uid == user.uid);
      events[getIndexOfEvent(event, events)].members!.add(user.uid!);
      allEventJoinRequests.update(event, (value) {
        value.remove(user);
        return value;
      });

      await _firestore.approveJoin(user, event).catchError((e) {
        errorSnackBar("Error! ${e.toString()}");
      });
    } else {
      errorSnackBar("Member limit reached! Cannot approve join request");
    }
  }

  void denyJoin(AppUser user, Event event) async {
    requestedEvents.removeWhere((e) => e.id == event.id);
    allEventJoinRequests[event]?.removeWhere((u) => u.uid == user.uid);
    allEventJoinRequests.update(event, (value) {
      value.remove(user);
      return value;
    });
    await _firestore.denyJoin(user, event).catchError((e) {
      errorSnackBar("Error! ${e.toString()}");
    });
  }

  Future<void> requestJoin(Event event) async {
    var isAdd = true;
    if (checkEventInList(event.id!, requestedEvents)) {
      isAdd = false;
      requestedEvents.removeWhere((e) => e.id == event.id);
      _auth.appUser.value.requestedEvents?.remove(event.id!);
    } else {
      requestedEvents.add(event);
      _auth.appUser.value.requestedEvents?.add(event.id!);
    }
    await _firestore.requestEvent(_auth.user.uid!, event.id!).catchError((e) {
      errorSnackBar(
          "Error Connecting to Database, Please check network connection!");
      if (isAdd) {
        requestedEvents.removeWhere((e) => e.id == event.id);
        _auth.appUser.value.requestedEvents?.remove(event.id!);
      } else {
        requestedEvents.add(event);
        _auth.appUser.value.requestedEvents?.add(event.id!);
      }
    });
  }

  void joinEvent(Event eventData) async {
    if ((eventData.members?.length ?? 0) >= (eventData.totalCapacity ?? 2)) {
      errorSnackBar("Event has reached it's member limit! ");
    } else {
      final event = getEventInList(eventData.id!, events);
      if (event == null) {
        return;
      }
      if (eventData.allowAutomaticJoin == true) {
        var isAdd = true;
        if (checkEventInList(event.id!, joinedEvents)) {
          isAdd = false;
          joinedEvents.removeWhere((e) => e.id == event.id);
          _auth.appUser.value.joinedEvents?.remove(event.id!);
          events[getIndexOfEvent(event, events)]
              .members!
              .remove(_auth.user.uid!);
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
            events[getIndexOfEvent(event, events)]
                .members!
                .remove(_auth.user.uid!);
          } else {
            joinedEvents.add(event);
            _auth.appUser.value.joinedEvents?.add(event.id!);
            events[getIndexOfEvent(event, events)]
                .members!
                .add(_auth.user.uid!);
          }
        });
      } else {
        await requestJoin(event);
      }
    }
  }

  List<String> sortTagsByFrequency() {
    // Count the frequency of each tag
    final tagFrequency = <String, int>{};
    for (final event in joinedEvents) {
      for (final tag in event.tags ?? []) {
        if (tagFrequency.containsKey(tag)) {
          tagFrequency[tag] = tagFrequency[tag]! + 1;
        } else {
          tagFrequency[tag] = 1;
        }
      }
    }

    // Sort the tags based on frequency in descending order
    final sortedTags = tagFrequency.keys.toList();
    sortedTags.sort((a, b) => tagFrequency[b]!.compareTo(tagFrequency[a]!));

    return sortedTags;
  }

  void deleteEvent(Event event) async {
    events.removeWhere((e) => e.id == event.id);
    ownedEvents.removeWhere((e) => e.id == event.id);
    bookmarkedEvents.removeWhere((e) => e.id == event.id);
    requestedEvents.removeWhere((e) => e.id == event.id);
    upvotedEvents.removeWhere((e) => e.id == event.id);
    reportedEvents.removeWhere((e) => e.id == event.id);
    joinedEvents.removeWhere((e) => e.id == event.id);
    allEventJoinRequests.removeWhere((key, value) => key.id == event.id);
    _auth.appUser.value.ownedEvents?.removeWhere((e) => e == event.id);
    _auth.appUser.value.bookmarkedEvents?.removeWhere((e) => e == event.id);
    _auth.appUser.value.requestedEvents?.removeWhere((e) => e == event.id);
    _auth.appUser.value.upvotedEvents?.removeWhere((e) => e == event.id);
    _auth.appUser.value.joinedEvents?.removeWhere((e) => e == event.id);
    final chat = ChatController.instance;
    chat.blockedChatGroups.removeWhere((e) => e.id == event.id);
    chat.joinedChatGroups.removeWhere((e) => e.id == event.id);
    chat.joinedChatGroupsWithoutBlocks.removeWhere((e) => e.id == event.id);
    chat.cancelAllSubscriptions();
    chat.fetchLatestMessages();
    await _firestore.deleteEvent(event).catchError((e) => errorSnackBar(
        "Error deleting the event please reload application: ${e.toString()}"));
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
    }).then((value) => sucessSnackBar("Bookmark sucessfully updated!"));
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
    }).then((value) => sucessSnackBar("Denied Reported Event Sucessfully!"));
  }
}
