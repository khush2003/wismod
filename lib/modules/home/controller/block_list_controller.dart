import 'package:get/get.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/shared/models/event.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/utils/app_utils.dart';

class BlockListController extends GetxController {
  final blockedChatGroupEventData = <Event>[].obs;
  final _auth = AuthController.instance;
  final _firestore = FirebaseService();

  @override
  void onInit() {
    getBlockedGroupsData();
    super.onInit();
  }

  void getBlockedGroupsData() {
    final events = HomeController.instance.events;
    final user = _auth.appUser.value;
    final blockedChatGroups = user.blockedChatGroups ?? [];

    final blockedChatGroupData = events
        .where((event) => blockedChatGroups.contains(event.id))
        .toList(); //
    blockedChatGroupEventData(blockedChatGroupData);
  }

  void unblockChatGroup(String eventId) async {
    try {
      await _firestore.unblockChatGroup(_auth.firebaseUser.value!.uid, eventId);
      blockedChatGroupEventData.remove(blockedChatGroupEventData
          .where((event) => event.id == eventId)
          .toList()[0]);
      await HomeController.instance.fetchEvents();
      sucessSnackBar('Complete!');
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }
}
