import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'chat_controller.dart';

class EventDetailController extends GetxController {
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;

  final _event = EventsController.instance;
  final _chat = ChatController.instance;

  final Rx<bool> isJoined = false.obs;
  final Rx<bool> isUpvoted = false.obs;
  final Rx<bool> isBookmarked = false.obs;
  final Rx<bool> isRequested = false.obs;
  final Rx<bool> isOwnedEvent = false.obs;

  final joinButtonText = 'Join'.obs;

  final tags = <String>[].obs;

  @override
  void onInit() async {
    setEvent();
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
    tags(eventData.value.tags);
    isLoading(false);
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
  }
}
