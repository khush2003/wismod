import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../shared/models/event.dart';
import '../../../theme/global_widgets.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Obx(() => homeController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchBox(th: th),
                          addHorizontalSpace(20),
                          const FilterButton()
                        ],
                      ),
                      addVerticalSpace(8),
                      OutlineButtonMedium(
                        onPressed: () => Get.toNamed(Routes.createEvent),
                        child: const Text('Create Event'),
                      ),
                      addVerticalSpace(16),
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: homeController.events.length,
                      itemBuilder: (context, index) {
                        return EventCard(event: homeController.events[index]);
                      },
                    ),
                  )
                ],
              )),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(107, 41, 237, 1),
                  offset: Offset(0, 4),
                  blurRadius: 6)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                  '#${event.category}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Text(event.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('${event.upvotes} upvotes',
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
                addVerticalSpace(20),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(event.imageUrl ?? placeholderImage,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                              placeholderImage,
                              fit: BoxFit.cover,
                            ),
                        fit: BoxFit.cover)),
                addVerticalSpace(20),
                if (event.eventDate != null)
                  Text(
                    'Date: ${formatDate(event.eventDate!)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                addVerticalSpace(20),
                Text('Event Owner: ${event.eventOwner.name}',
                    style: Theme.of(context).textTheme.bodyMedium),
                addVerticalSpace(20),
                if (event.description != null)
                  Text('Details: ${event.description}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3),
              ]),
              addVerticalSpace(20),
              OutlineButtonMedium(
                  child: const Text("Read More"),
                  onPressed: () {
                    // Todo: Function to go to event detail page
                    Get.toNamed(Routes.eventDetials,
                        parameters: {'id': event.id!});
                  })
            ],
          ),
        ));
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Get.toNamed(
            Routes.filterOptions,
          );
        },
        icon: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.black,
          size: 35,
        ));
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.th});
  final ThemeData th;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
            // suffixIcon: const Icon(Icons.search_rounded),
            // suffixIconColor: th.colorScheme.primary,
            hintText: "Search",
            hintStyle: TextStyle(
                fontFamily: "Gotham",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: th.colorScheme.primary),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: th.colorScheme.primary)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: th.colorScheme.primary))),
        maxLines: 1,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
