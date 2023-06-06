import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/user.dart';
import 'chat_controller.dart';

class EventDetailController extends GetxController {
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;

  static EventDetailController get instance =>
      Get.find<EventDetailController>();

  final _event = EventsController.instance;
  final _chat = ChatController.instance;

  final Rx<bool> isJoined = false.obs;
  final Rx<bool> isUpvoted = false.obs;
  final Rx<bool> isBookmarked = false.obs;
  final Rx<bool> isRequested = false.obs;
  final Rx<bool> isOwnedEvent = false.obs;
  final Rx<bool> isMemberLimitReached = false.obs;
  final Rx<int> upvotes = 0.obs;

  final memberList = <AppUser>[].obs;
  final requestedUsers = <AppUser>[].obs;
  final joinButtonText = 'Join'.obs;

  final tags = <String>[].obs;

  @override
  void onInit() async {
    setEvent();
    setMemberList();
    super.onInit();
  }

  void setEvent() {
    isLoading(true);
    var eventId = Get.parameters['id'] ?? '2l8UVLQgFin3dthssdlI';
    eventData(_event.events.where((event) => event.id == eventId).first);
    setIsRequested();
    setIsJoined();
    setIsUpvoted();
    setIsBookmarked();
    setIsOwnedEvent();
    setIsMemberLimitReached();
    setUpvotes();
    tags(eventData.value.tags);
    isLoading(false);
  }

  void setUpvotes() {
    upvotes(eventData.value.upvotes);
  }

  void setIsUpvoted() {
    if (checkEventInList(eventData.value.id!, _event.upvotedEvents)) {
      isUpvoted(true);
    } else {
      isUpvoted(false);
    }
  }

  void setIsJoined() {
    if (checkEventInList(eventData.value.id!, _event.joinedEvents)) {
      joinButtonText('Joined');
      isJoined(true);
    } else {
      isJoined(false);
    }
  }

  void setIsRequested() {
    final auth = AuthController.instance;
    if (!eventData.value.allowAutomaticJoin) {
      joinButtonText('Request Join');
      if (auth.user.requestedEvents?.contains(eventData.value.id!) ?? false) {
        joinButtonText('Request Sent');
        isRequested(true);
      } else {
        isRequested(false);
      }
    }
  }

  void setIsBookmarked() {
    if (_event.bookmarkedEvents
        .any((event) => event.id == eventData.value.id)) {
      isBookmarked(true);
    } else {
      isBookmarked(false);
    }
  }

  void setIsOwnedEvent() {
    if (checkEventInList(eventData.value.id!, _event.ownedEvents)) {
      isOwnedEvent(true);
    } else {
      isOwnedEvent(false);
    }
  }

  void upvoteEvent() async {
    _event.upvoteEvent(eventData.value);
    setIsUpvoted();
    if (isUpvoted.value) {
      upvotes(upvotes.value + 1);
    } else {
      upvotes(upvotes.value - 1);
    }
  }

  void reportEvent() async {
    _event.reportEvent(eventData.value);
  }

  void reportEventDeny() async {
    _event.reportEventDeny(eventData.value);
  }

  void joinEvent() async {
    _event.joinEvent(eventData.value);
    setIsRequested();
    setIsJoined();
  }

  void bookmarkEvent() async {
    _event.bookmarkEvent(eventData.value);
    setIsBookmarked();
  }

  void chatGroupAdd() async {
    _chat.joinChatGroup(eventData.value);
    await FirebaseMessaging.instance.subscribeToTopic('${eventData.value.id}');
  }

  void setIsMemberLimitReached() {
    if ((eventData.value.members?.length ?? 0) >=
        (eventData.value.totalCapacity ?? 2)) {
      isMemberLimitReached(true);
    } else {
      isMemberLimitReached(false);
    }
  }

  void setMemberList() {
    memberList.clear();
    requestedUsers.clear();
    if (_event.allEventMemberList.containsKey(eventData.value)) {
      memberList.addAll(_event.allEventMemberList[eventData.value]!);
    }
    if (_event.allEventJoinRequests.containsKey(eventData.value)) {
      requestedUsers.addAll(_event.allEventJoinRequests[eventData.value]!);
    }
  }
}

class RequestedUser {
  final String firstName;
  final String lastName;
  final String profilePicture;

  RequestedUser({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });
}
