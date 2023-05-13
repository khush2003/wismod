import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/modules/home/controller/admin_controller.dart';
import '../../../shared/models/event.dart';
import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class AdminView extends StatelessWidget {
  AdminView({Key? key}) : super(key: key);
  final adminController = Get.put(AdminController());
  final _event = EventsController.instance;

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
            Flexible(
              child: Obx(() {
                if (adminController.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return Obx(() => ListView.builder(
                      itemCount: _event.reportedEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: _event.reportedEvents[index],
                        );
                      },
                    ));
              }),
            )
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
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
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              event.imageUrl ?? placeholderImage,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                    placeholderImage,
                                    fit: BoxFit.cover,
                                  ),
                              fit: BoxFit.cover),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            Text(
                              formatDate(event.eventDate!),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              event.title.length <= 15
                                  ? event.title
                                  : '${event.title.substring(0, 15)}...',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              event.location.length <= 30
                                  ? event.location
                                  : '${event.location.substring(0, 30)}...',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Category: ${event.category}',
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlineButtonMedium(
                          onPressed: () => {
                            Get.toNamed(Routes.eventDetials,
                                parameters: {'id': event.id!})
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text('More'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
