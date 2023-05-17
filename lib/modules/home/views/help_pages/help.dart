import 'package:flutter/material.dart';
import 'package:wismod/theme/global_widgets.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart';
import '../../controller/password_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Help",
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
                      children: [
                        const TopicOfHelper(
                          label: 'Event',
                        ),
                        TextButtonSection(
                          text: "How Can I start looking for events?",
                          onPressed: () {
                            Get.toNamed(Routes.event_1);
                          },
                        ),
                        TextButtonSection(
                          text: "How Can I create an event?",
                          onPressed: () {
                            Get.toNamed(Routes.event_2);
                          },
                        ),
                        TextButtonSection(
                          text: "How Can I manage my event?",
                          onPressed: () {
                            Get.toNamed(Routes.event_3);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
                    child: Column(
                      children: [
                        const TopicOfHelper(
                          label: 'Chat',
                        ),
                        TextButtonSection(
                          text: "How Can I start a chat?",
                          onPressed: () {
                            //effect here
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0),
                    child: Column(
                      children: [
                        const TopicOfHelper(
                          label: 'Dashboard',
                        ),
                        TextButtonSection(
                          text: "What is a dash board?",
                          onPressed: () {
                            //effect here
                          },
                        ),
                      ],
                    ),
                  ),
                ])))));
  }
}

class TextButtonSection extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;
  const TextButtonSection({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontFamily: "Gotham",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
                alignment: Alignment.centerLeft,
              ),
              onPressed: onPressed,
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}

class TopicOfHelper extends StatelessWidget {
  final String label;
  const TopicOfHelper({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          label,
          style: const TextStyle(
              fontFamily: "Gotham",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black),
        ),
      ),
    ]);
  }
}
