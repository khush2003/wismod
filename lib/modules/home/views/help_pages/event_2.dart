import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/utils/uni_icon.dart';

class HelpEvent2 extends StatelessWidget {
  const HelpEvent2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Event creating",
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
                          label: 'How to Create an event',
                        ),
                        BodyCreate1(icon: Icons.circle),
                        BodyCreate2(icon: Icons.circle),
                        BodyCreate3(icon: Icons.circle),
                        BodyCreate4(),
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

class BodyCreate1 extends StatelessWidget {
  final IconData icon;
  const BodyCreate1({
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
                  -8), // Adjust the offset to align the icon with the desired position
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
                        text: "Go to Home page by clicking Home icon",
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
                        text: "far left in the bottom bar.",
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

class BodyCreate2 extends StatelessWidget {
  final IconData icon;
  const BodyCreate2({
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
                        text: "Click on the create button",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 1.0),
                          child: UnIcon(UniconsLine.plus,
                              size: 20, color: Color.fromRGBO(123, 56, 255, 1)),
                        ),
                      ),
                      TextSpan(
                        text: "on the bottom left of the screen.",
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
                            "In creating page, you can create event that will require these details",
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

class BodyCreate4 extends StatelessWidget {
  final IconData? icon;
  const BodyCreate4({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 17,
                color: const Color.fromARGB(255, 151, 54, 248),
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
                            "-Event name. \n-Picture of the event(optional) \n-Event detail. \n-Amout of people that can join the event. \n-Location of the evnt \n-Date of the event. \n-Category of the event \n-Tags that you can include in the event(optional). \nThen you can click create event button to create the event",
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
                            "You can allow other people to join your event automatically By toggle on the option\"Allow Automatic Join\" at the bottom of the creating event page",
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
