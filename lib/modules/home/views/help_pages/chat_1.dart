import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/utils/uni_icon.dart';

class HelpChat1 extends StatelessWidget {
  const HelpChat1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Chatting",
          style: TextStyle(
              fontFamily: "Gotham",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.black),
        )),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
                    child: Column(
                      children: const [
                        Topic(
                          label: 'How to join a chat',
                        ),
                        BodyChat1(icon: Icons.circle),
                        BodyChat2(icon: Icons.circle),
                        BodyCreate3(icon: Icons.circle),
                        BodyCreate5(icon: Icons.star),
                      ],
                    ),
                  ),
                ])))));
  }
}

class Topic extends StatelessWidget {
  final String label;
  const Topic({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}

class BodyChat1 extends StatelessWidget {
  final IconData icon;
  const BodyChat1({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Transform.translate(
              offset: const Offset(0,
                  -18), // Adjust the offset to align the icon with the desired position
              child: Icon(
                icon,
                size: 17,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "When you click \"Read more\" button of events, you will see more details, which's including the option to join the chat of that event.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyChat2 extends StatelessWidget {
  final IconData icon;
  const BodyChat2({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Transform.translate(
              offset: const Offset(0,
                  4), // Adjust the offset to align the icon with the desired position
              child: Icon(
                icon,
                size: 17,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "In event's details, click on the \"Chat\" button to join a group chat of that event. You will autumatically got moved to the group chat page",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyCreate3 extends StatelessWidget {
  final IconData icon;
  const BodyCreate3({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Transform.translate(
              offset: const Offset(0,
                  4), // Adjust the offset to align the icon with the desired position
              child: Icon(
                icon,
                size: 17,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "In group chat page, you can start chatting with the event owner. Including other people who join in this chat",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyCreate5 extends StatelessWidget {
  final IconData icon;
  const BodyCreate5({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Transform.translate(
              offset: const Offset(0,
                  4), // Adjust the offset to align the icon with the desired position
              child: Icon(
                icon,
                size: 20,
                color: Colors.purple,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Group chat of events will be saved in chat room page. You can always comeback to this page to see and continue your chatting by click on the Chat icon",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 1.0),
                          child: UnIcon(UniconsLine.comment,
                              size: 20, color: Color.fromRGBO(123, 56, 255, 1)),
                        ),
                      ),
                      TextSpan(
                        text: "next to Home icon",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 1.0),
                          child: UnIcon(UniconsLine.estate,
                              size: 20, color: Color.fromRGBO(123, 56, 255, 1)),
                        ),
                      ),
                      TextSpan(
                        text: "in the bottom bar",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
