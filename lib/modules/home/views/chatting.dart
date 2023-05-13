import 'package:flutter/material.dart';
import 'package:wismod/modules/auth/controllers/auth_controller.dart';
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/theme/theme_data.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/message_controller.dart';

const double textTimeMargin = 30;

//TODO: Add a listener to subscibe to the changes in messages. (Show new meessage when another user sends a message)
class ChattingView extends StatelessWidget {
  ChattingView({super.key});
  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.eventData.value.title,
                    style: const TextStyle(
                      fontSize: 28,
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
                      fontSize: 20,
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
              controller.blockChatGroup();
            },
            icon: const Icon(Icons.block),
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(201, 173, 255, 1),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(sideWidth),
              child: Align(
                alignment: Alignment.topCenter,
                child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        return ChatBoxUser(message: controller.messages[index]);
                      },
                    )),
              ),
            )),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(201, 173, 255, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 20,
                        child: TextFormField(
                          controller: controller.messageTextController,
                          //textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Type Something...",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Gotham'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Send Button
                    SizedBox(
                      width: 80,
                      height: double.infinity,
                      child: ElevatedButton(
                        // Send text
                        onPressed: () => controller.createMessage(),
                        child: const Text('Send'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBoxUser extends StatelessWidget {
  final Message message;
  final _auth = AuthController.instance;
  ChatBoxUser({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // final DateTime timeNow = DateTime.now();
    // final String formattedTime = formatDate(timeNow);
    //final TextDirection? textDirection;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: message.sentBy == _auth.firebaseUser.value!.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: message.sentBy == _auth.firebaseUser.value!.uid
                      ? 0
                      : textTimeMargin,
                  left: message.sentBy == _auth.firebaseUser.value!.uid
                      ? textTimeMargin
                      : 0),
              child: Text(
                //chatUserName,
                message.userName,
                style: const TextStyle(
                  fontFamily: "Gotham",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        addVerticalSpace(5),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: message.sentBy == _auth.firebaseUser.value!.uid
                  ? textTimeMargin
                  : 0,
              right: message.sentBy == _auth.firebaseUser.value!.uid
                  ? 0
                  : textTimeMargin),
          child: Padding(
            padding: EdgeInsets.only(
                left: message.sentBy == _auth.firebaseUser.value!.uid
                    ? textTimeMargin
                    : 0,
                right: message.sentBy == _auth.firebaseUser.value!.uid
                    ? 0
                    : textTimeMargin),
            child: Column(
              children: <Widget>[
                Row(
                  textDirection: message.sentBy == _auth.firebaseUser.value!.uid
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Chat msg
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(sideWidth),
                        //margin:
                        //    const EdgeInsets.only(right: textTimeMargin),
                        decoration: BoxDecoration(
                          // Circular Edge Chat
                          //borderRadius: BorderRadius.circular(50),
                          color: message.sentBy == _auth.firebaseUser.value!.uid
                              ? AppThemeData.themedata.colorScheme.secondary
                              : Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              offset: Offset(0, 4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message.message,
                              style: const TextStyle(
                                fontFamily: "Gotham",
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(10),
                    // UserProfilePic
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(
                              message.profilePicture ?? placeholderImage,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                placeholderImage,
                                fit: BoxFit.cover,
                              ),
                            ).image,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                addVerticalSpace(10),
                Row(
                  mainAxisAlignment:
                      message.sentBy == _auth.firebaseUser.value!.uid
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(formatDateTime(message.sentOn!)),
                  ],
                ),
              ],
            ),
          ),
        ),
        addVerticalSpace(10),
      ],
    );
  }
}
