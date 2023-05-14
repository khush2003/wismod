import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/models/user.dart';
import '../../../shared/services/firebase_firestore_serivce.dart';
import 'chat_controller.dart';

class EventDetailController extends GetxController {
  final Rx<Event> eventData = Event.empty().obs;
  final isLoading = true.obs;

  static EventDetailController get instance =>
      Get.find<EventDetailController>();

  final _event = EventsController.instance;
  final _chat = ChatController.instance;
  final _firestore = FirebaseService();

  final Rx<bool> isJoined = false.obs;
  final Rx<bool> isUpvoted = false.obs;
  final Rx<bool> isBookmarked = false.obs;
  final Rx<bool> isRequested = false.obs;
  final Rx<bool> isOwnedEvent = false.obs;

  final RxList<String> memberList = <String>[].obs;
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

  void setMemberList() {
    memberList.clear();
    final List<String> tempMemberList = eventData.value.members ?? [];
    memberList.addAll(tempMemberList);
  }

  void removeMember(String userId) async {
    eventData.update((event) {
      event!.members?.remove(userId);
    });

    try {
      await _firestore.deleteMemberFromEvent(eventData.value.id!, userId);
      print('Member removed successfully.');
      EventDetailController.instance.memberList.remove(userId);
    } catch (error) {
      print('Error removing member: $error');
    }
  }

  // Future<String> _getUserName(String userId) async {
  //   final users = await _firestore.getUserById(userId);
  //   print('${users!.firstName}');
  //   return "${users.firstName} ${users.lastName}";
  // }
  // Future<void> setMemberList() async {
  //   memberList.clear();
  //   final List<String> tempMemberList = eventData.value.members ?? [];
  //   for (String userId in tempMemberList) {
  //     final AppUser? user = await _firestore.getUserById(userId);

  //     if (user != null) {
  //       memberList.add(user);
  //     }
  //   }
  //   print('temp member: ${tempMemberList} \n MemberList: ${memberList}');
  // }
}
