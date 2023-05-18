import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/utils/uni_icon.dart';

class HelpEvent3 extends StatelessWidget {
  const HelpEvent3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Event managing",
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
                          label: 'How to manage event',
                        ),
                        BodyManage1(icon: Icons.circle),
                        BodyManage2(icon: Icons.circle),
                        BodyManage3(icon: Icons.circle),
                        BodyManage4(),
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

class BodyManage1 extends StatelessWidget {
  final IconData icon;
  const BodyManage1({
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
                  -19), // Adjust the offset to align the icon with the desired position
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
                            "Go to Dashboard page by clicking on the Dashboard icon",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 1.0),
                          child: UnIcon(
                            UniconsLine.apps,
                            size: 20,
                            color: Color.fromRGBO(123, 56, 255, 1),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " in the middle of the bottom bar",
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

class BodyManage2 extends StatelessWidget {
  final IconData icon;
  const BodyManage2({
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
                            "In the Dashboard page, click on the \"Events You Own\" tab, will show all of events that you're the owner",
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

class BodyManage3 extends StatelessWidget {
  final IconData icon;
  const BodyManage3({
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
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Click on your event will show the page of your event in owner view.",
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

class BodyManage4 extends StatelessWidget {
  final IconData? icon;
  const BodyManage4({
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
                        text: "In this owner view, you can",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text:
                            "\n-Edit event. You can edit all of details of your event, by clicking an \"Edit event button\". \n-Remove event. You can remove your event by cliking \"Remove\" button at the bottom of the page",
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
