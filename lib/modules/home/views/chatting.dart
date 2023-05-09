// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:wismod/shared/models/message.dart';
import 'package:wismod/shared/services/firebase_firestore_serivce.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/message_controller.dart';
import '../../../routes/routes.dart';

const double textTimeMargin = 30;

class ChattingView extends StatelessWidget {
  ChattingView({super.key});
  final controller = Get.put(MessageController());
  Message messageData() => controller.messageData.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Using Event Owner Name later
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Event",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  addVerticalSpace(5),
                  const Text(
                    "Event Host",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.block),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(201, 173, 255, 1),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(sideWidth),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.events.length,
                      itemBuilder: (context, index) {
                        return ChatBoxUser(message: controller.events[index]);
                      },
                    ),

                    /*ChatBoxEventHost(
                      chatUserName: 'John Hotfoot',
                      chatUserProfileUrl:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                      chatText: 'How you doin bruv?',
                      chatUserId: 21,
                      chatTime: TimeOfDay(hour: 22, minute: 0),
                    ),
                    addVerticalSpace(10),
                    ChatBoxUser(
                      chatUserName: 'Jane Vive',
                      chatUserProfileUrl:
                          'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80&q=80',
                      chatText: 'Not great mate, just wanna join your team bro',
                      chatUserId: 12,
                      chatTime: TimeOfDay(hour: 22, minute: 2),
                    ),
                    addVerticalSpace(10),
                    ChatBoxEventHost(
                      chatUserName: 'John Hotfoot',
                      chatUserProfileUrl:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                      chatText: 'Sure dude!',
                      chatUserId: 21,
                      chatTime: TimeOfDay(hour: 22, minute: 3),
                    ),
                    addVerticalSpace(10),
                    ChatBoxEventHost(
                      chatUserName: 'John Hotfoot',
                      chatUserProfileUrl:
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                      chatText: 'See you tomorrow',
                      chatUserId: 21,
                      chatTime: TimeOfDay(hour: 22, minute: 3),
                    ),
                    addVerticalSpace(10),
                    ChatBoxUser(
                      chatUserName: 'Jane Vive',
                      chatUserProfileUrl:
                          'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80&q=80',
                      chatText: 'Thanks man',
                      chatUserId: 12,
                      chatTime: TimeOfDay(hour: 22, minute: 5),
                    ),
                    addVerticalSpace(10),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
                          //textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
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
                    SizedBox(
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

class ChatBoxEventHost extends StatelessWidget {
  final String chatUserName;
  final String? chatUserProfileUrl;
  final String chatText;
  final int chatUserId;
  final TimeOfDay chatTime;

  ChatBoxEventHost({
    super.key,
    required this.chatUserName,
    this.chatUserProfileUrl,
    required this.chatText,
    required this.chatUserId,
    required this.chatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: textTimeMargin),
                    child: Text(
                      chatUserName,
                      style: const TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textDirection: ui.TextDirection.ltr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        addVerticalSpace(5),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(right: textTimeMargin),
          /*decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 1),
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),*/
          child: Column(
            children: [
              Padding(
                //padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                padding: const EdgeInsets.only(right: textTimeMargin),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // UserProfilePic
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (chatUserProfileUrl != null)
                              SizedBox(
                                //width: 80,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: Image.network(
                                    chatUserProfileUrl!,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.network(
                                      placeholderImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ).image,
                                ),
                              ),
                          ],
                        ),
                        addHorizontalSpace(10),
                        // Chat msg
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(sideWidth),
                            //margin:
                            //    const EdgeInsets.only(right: textTimeMargin),
                            decoration: BoxDecoration(
                              // Circular Edge Chat
                              //borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(255, 255, 255, 1),
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
                                  chatText,
                                  style: const TextStyle(
                                    fontFamily: "Gotham",
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  textDirection: ui.TextDirection.ltr,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(chatTime.format(context)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        addVerticalSpace(10),
        /*Container(
          margin: const EdgeInsets.only(right: textTimeMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              addHorizontalSpace(20),
              Text(chatTime.format(context)),
            ],
          ),
        )*/
      ],
    );
  }
}

class ChatBoxUser extends StatelessWidget {
  final Message message;
  const ChatBoxUser({super.key, required this.message});

  /*final String chatUserName;
  final String? chatUserProfileUrl;
  final String chatText;
  final int chatUserId;
  final TimeOfDay chatTime;

  ChatBoxUser({
    super.key,
    required this.chatUserName,
    this.chatUserProfileUrl,
    required this.chatText,
    required this.chatUserId,
    required this.chatTime,
  });*/

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseService().getUserById(message.userId);
    final DateTime timeNow = DateTime.now();
    final String formattedTime = DateFormat.Hms().format(timeNow);
    //final TextDirection? textDirection;

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: textTimeMargin),
                    child: Text(
                      //chatUserName,
                      userName.toString(),
                      style: const TextStyle(
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textDirection: ui.TextDirection.rtl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        addVerticalSpace(5),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: textTimeMargin),
          /*decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 1),
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),*/
          child: Column(
            children: [
              Padding(
                //padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                padding: const EdgeInsets.only(left: textTimeMargin),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Chat msg
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(sideWidth),
                            //margin:
                            //    const EdgeInsets.only(right: textTimeMargin),
                            decoration: BoxDecoration(
                              // Circular Edge Chat
                              //borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(255, 255, 255, 1),
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
                                  textDirection: ui.TextDirection.rtl,
                                )
                              ],
                            ),
                          ),
                        ),
                        addHorizontalSpace(10),
                        // UserProfilePic
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (message.imageUrl != null)
                              SizedBox(
                                //width: 80,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: Image.network(
                                    message.imageUrl!,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(message.sentOn.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        addVerticalSpace(10),
      ],
    );
  }
}
