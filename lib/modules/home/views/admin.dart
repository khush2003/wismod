import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../theme/global_widgets.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin's Page",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report Requests',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            EventCard(
              eventDate: DateTime.now(),
              eventName: 'Marathon',
              eventLocation: 'IconSiam',
              eventCategory: 'Exercise',
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final DateTime eventDate;
  final String eventName;
  final String eventLocation;
  final String eventCategory;

  const EventCard({
    required this.eventDate,
    required this.eventName,
    required this.eventLocation,
    required this.eventCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Color(0xFF8C52FF),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 7,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1452626038306-9aae5e071dd3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFyYXRob258ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat("dd/MM/yyyy").format(eventDate),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              eventName,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              eventLocation,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Category: $eventCategory',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('18 upvotes'),
                  OutlineButtonMedium(
                    onPressed: () => {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('More'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
