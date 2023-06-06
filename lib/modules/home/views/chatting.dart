import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/modules/home/controller/event_detail_controller.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/message_controller.dart';

import '../controller/chat_controller.dart';

const double textTimeMargin = 30;

final _auth = AuthController.instance;
final _event = EventDetailController.instance;
final _chat = ChatController.instance;

/*final DocumentSnapshot snap = FirebaseFirestore.instance
    .collection('Users')
    .doc(_auth.firebaseUser.value!.uid)
    .get() as DocumentSnapshot<Map<String, dynamic>>;*/
//String token = snap['Token'];
// class ScrollPositionController extends GetxController {
//   final ScrollController scrollController = ScrollController();
//   @override
//   void onReady() {
//     scrollController.animateTo(scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
//     super.onReady();
//   }
// }

class ChattingView extends StatelessWidget {
  ChattingView({super.key});
  final controller = Get.put(MessageController());
  // final _scrollController = Get.put(ScrollPositionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(children: [
                Expanded(
                  child: Obx(() => ListView.separated(
                        // controller: _scrollController.scrollController,
                        separatorBuilder: (context, index) =>
                            addVerticalSpace(),
                        shrinkWrap: true,
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          if (index == 0 ||
                              index == controller.messages.length - 1) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: index == 0 ? 16 : 0,
                                  bottom: index == 0 ? 16 : 8),
                              child: ChatBubble(
                                  message: controller.messages[index]),
                            );
                          }
                          return ChatBubble(
                              message: controller.messages[index]);
                        },
                      )),
                ),
              ]),
            )),
      bottomNavigationBar: EnterMessageBar(
        controller: controller,
        // scrollController: _scrollController.scrollController,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.eventData.value.title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalSpace(5),
                Text(
                  controller.eventData.value.eventOwner.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
      actions: [
        IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Confirmation',
              content: const Text(
                  'Are you sure you want to block this chat group?',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              actions: [
                OutlineButtonMedium(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text('Cancel'),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                    controller.blockChatGroup();
                  },
                  child: const Text('Block'),
                ),
              ],
            );
          },
          icon: const Icon(Icons.block),
        ),
      ],
      centerTitle: false,
      shape:
          const Border(bottom: BorderSide(color: Colors.black26, width: 0.5)),
      backgroundColor: Colors.white,
      toolbarHeight: 80,
    );
  }
}

class EnterMessageBar extends StatelessWidget {
  // final ScrollController scrollController;
  const EnterMessageBar({
    super.key,
    required this.controller,
    // required this.scrollController,
  });

  final MessageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextFormField(
                  style: Theme.of(context).textTheme.displayMedium,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Type Something...",
                    hintStyle: TextStyle(
                        fontFamily: "Gotham",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600]),
                  ),
                  controller: controller.messageTextController,
                ),
              ),
              addHorizontalSpace(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(50, 50),
                    alignment: Alignment.center,
                    minimumSize: Size.zero,
                    backgroundColor: primary,
                    shape: const CircleBorder()),
                child: const Icon(Icons.send),
                onPressed: () {
                  if (controller.messageTextController.text.isNotEmpty) {
                    controller.createMessage();
                    // Send notification using FCM tokens to user in the joinedChatGroups list
                    /*final DocumentSnapshot snap = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(_auth.firebaseUser.value!.uid)
                        .get() as DocumentSnapshot<Map<String, dynamic>>;
                    String token = snap['Token'];
                    print(token);*/
 
                    controller.sendPushMessage(
                        // change this token to people who subscribe to the event
                        _event.eventData.value.id!,
                        _auth.appUser.value.getName() +
                            ": " +
                            controller.messageTextController.text,
                        controller.eventData.value.title);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final _auth = AuthController.instance;
  ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.sentBy == _auth.appUser.value.uid) {
      return ChatBubbleRight(message: message);
    }
    return ChatBubbleLeft(message: message);
  }
}

class ChatBubbleRight extends StatelessWidget {
  final Message message;
  const ChatBubbleRight({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SendDate(message: message),
              addHorizontalSpace(),
              UserName(message: message, isOwner: true)
            ],
          ),
          addVerticalSpace(),
          MessageBox(message: message, isOwner: true),
        ],
      ),
    );
  }
}

class ChatBubbleLeft extends StatelessWidget {
  final Message message;
  const ChatBubbleLeft({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ProfilePicture(message: message),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              children: [
                UserName(message: message),
                addHorizontalSpace(),
                SendDate(message: message)
              ],
            ),
            addVerticalSpace(),
            MessageBox(message: message)
          ],
        )
      ],
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.message, this.isOwner = false});
  final bool isOwner;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * chatboxWidthRatio,
          maxHeight: MediaQuery.of(context).size.height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(20),
              bottomLeft: const Radius.circular(20),
              bottomRight: isOwner
                  ? const Radius.circular(0)
                  : const Radius.circular(20),
              topLeft: isOwner
                  ? const Radius.circular(20)
                  : const Radius.circular(0)),
          color: isOwner ? primary : const Color(0xfff0f0f0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              message.message,
              style: TextStyle(
                fontFamily: "Gotham",
                color: isOwner ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SendDate extends StatelessWidget {
  const SendDate({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Text(formatDateTime(message.sentOn!),
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black));
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key, required this.message, this.isOwner = false});
  final bool isOwner;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Text(
      //chatUserName,
      isOwner
          ? 'You'
          : message.userName.length > 15
              ? '${message.userName.substring(0, 15)}..'
              : message.userName,
      style: const TextStyle(
        fontFamily: "Gotham",
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 16,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        child: CircleAvatar(
          radius: 25,
          backgroundImage: Image.network(
            message.profilePicture ?? placeholderImageUserPurple,
            errorBuilder: (context, error, stackTrace) => Image.network(
              placeholderImageUserPurple,
              fit: BoxFit.cover,
            ),
          ).image,
        ),
      ),
    );
  }
}
