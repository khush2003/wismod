import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/utils/uni_icon.dart';

class HelpEvent1 extends StatelessWidget {
  const HelpEvent1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Event searching",
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
                          label: 'How to search event',
                        ),
                        BodySearch1(icon: Icons.circle),
                        BodySearch2(icon: Icons.circle),
                        BodySearch3(icon: Icons.star),
                        BodySearch4(),
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

class BodySearch1 extends StatelessWidget {
  final IconData icon;
  const BodySearch1({
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
                        padding: EdgeInsets.only(
                          right: 1.0,
                        ),
                        child: UnIcon(UniconsLine.estate,
                            size: 20, color: Color.fromRGBO(123, 56, 255, 1)),
                      )),
                      TextSpan(
                        text: "in far left of the bottom bar",
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

class BodySearch2 extends StatelessWidget {
  final IconData icon;
  const BodySearch2({
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
                            "Click on the search bar and then type the event you want to search by entering a name or tag of the event.",
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

class BodySearch3 extends StatelessWidget {
  final IconData icon;
  const BodySearch3({
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
                        text: "You can sort event by clicking the Sort icon",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 1.0),
                          child: UnIcon(
                            UniconsLine.sliders_v,
                            color: Color.fromRGBO(123, 56, 255, 1),
                            size: 20,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "That's next to a search bar.",
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

class BodySearch4 extends StatelessWidget {
  final IconData? icon;
  const BodySearch4({
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
                            "You can can sort by\n  -Choose category of event that you want to see.\n  -Choose the sort by date which will show order from latest or oldest event",
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
