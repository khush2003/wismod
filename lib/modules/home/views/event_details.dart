import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/event_detail_controller.dart';
import 'package:wismod/utils/app_utils.dart';

class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});
  final controller = Get.put(EventDetailController());
  @override
  Widget build(BuildContext context) {
    final eventData = controller.eventData.value;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.report)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          children: [
            if (eventData.imageUrl != null)
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(eventData.imageUrl!, fit: BoxFit.cover)),
                  Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Text(eventData.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('$eventData.upvotes upvotes',
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
          ],
        ),
      )),
    );
  }
}
