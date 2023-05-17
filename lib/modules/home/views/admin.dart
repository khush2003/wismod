import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/events_controller.dart';
import 'package:wismod/modules/home/views/home.dart';
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
                  return const LoadingWidget();
                }
                return Obx(() => _event.reportedEvents.length == 0
                    ? Center(child: const Text('No events reported currently!'))
                    : Obx(() => ListView.builder(
                          itemCount: _event.reportedEvents.length,
                          itemBuilder: (context, index) {
                            final event = _event.reportedEvents[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.eventDetials,
                                    parameters: {'id': event.id!});
                              },
                              child: EventCard(
                                event: event,
                              ),
                            );
                          },
                        )));
              }),
            )
          ],
        ),
      ),
    );
  }
}
