// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHAT ROOMS",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(201, 173, 255, 1),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Using a real data submit later
                ChatEvent(
                  eventImageUrl:
                      'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                  eventTitle: 'KMUTT BioHackathon',
                  eventOwner: 'John Hotfoot',
                  latestChat: 'Hello!',
                  eventId: 5,
                ),
                addVerticalSpace(16),
                ChatEvent(
                  eventImageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s',
                  eventTitle: 'Let' 's play a Board Game',
                  eventOwner: 'Khush Agarwal',
                  latestChat: 'It is time to play Board game guys!!!!',
                  eventId: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatEvent extends StatelessWidget {
  final String? eventImageUrl;
  final String eventTitle;
  final String eventOwner;
  final String latestChat;
  final int eventId;

  ChatEvent(
      {super.key,
      this.eventImageUrl,
      required this.eventTitle,
      required this.eventOwner,
      required this.latestChat,
      required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).navigationBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(107, 41, 237, 1),
              offset: Offset(0, 4),
              blurRadius: 6),
        ],
      ),
      child: OutlinedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (eventImageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            eventImageUrl!,
                            // Image size adjustment here
                            width: 100,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          eventTitle,
                          style: const TextStyle(
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        addVerticalSpace(5),
                        Text(
                          'Owner: $eventOwner',
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          latestChat,
                          style: const TextStyle(
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
