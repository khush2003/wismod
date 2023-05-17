import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/shared/services/notification_service.dart';
import 'package:wismod/utils/app_utils.dart';
import 'package:wismod/utils/uni_icon.dart';

import '../../../routes/routes.dart';
import '../../../shared/models/event.dart';
import '../../../theme/global_widgets.dart';
import '../../../theme/theme_data.dart';
import 'filter_options.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondary,
        onPressed: () => Get.toNamed(Routes.createEvent),
        child: const UnIcon(UniconsLine.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: sideWidth, left: sideWidth, right: sideWidth),
        child: Obx(() => homeController.isLoading.value
            ? const LoadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      addVerticalSpace(16),
                    ],
                  ),
                  Flexible(
                    child: Obx(() => ListView.builder(
                          itemCount: homeController.filteredEvents.length,
                          itemBuilder: (context, index) {
                            return EventCard(
                                event: homeController.filteredEvents[index]);
                          },
                        )),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () =>
              Get.toNamed(Routes.eventDetials, parameters: {'id': event.id!}),
          child: Column(
            children: [
              PictureSection(
                event: event,
              ),
              DetailSection(event: event),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  const DetailSection({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(event.category.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70)),
              Text('${event.upvotes} ▲',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70))
            ],
          ),
          addVerticalSpace(4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 100),
            child: Text(
              event.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          addVerticalSpace(),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: Text(
                event.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, height: 1.3),
              )),
          addVerticalSpace(),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: Text(
                formatDate(event.eventDate!),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, height: 1.3),
              )),
        ],
      ),
    );
  }
}

class PictureSection extends StatelessWidget {
  const PictureSection({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Image.network(event.imageUrl ?? placeholderImage,
              errorBuilder: (context, error, stackTrace) => Image.network(
                    placeholderImage,
                    fit: BoxFit.cover,
                  ),
              fit: BoxFit.cover)),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(53, 50),
          alignment: Alignment.centerLeft,
          minimumSize: Size.zero,
          backgroundColor: primary,
          shape: const CircleBorder()),
      child: const UnIcon(
        UniconsLine.sliders_v,
        color: Colors.white,
        size: 20,
      ),
      onPressed: () {
        Get.bottomSheet(FilterOptionsView());
      },
    );
  }
}

class SearchBox extends StatelessWidget {
  SearchBox({super.key, required this.th});
  final ThemeData th;
  final HomeController controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller.searchController,
        onChanged: (value) {
          controller.searchEvents();
        },
        decoration: InputDecoration(
            hintText: "Search Events...",
            contentPadding: const EdgeInsets.all(20),
            hintStyle: const TextStyle(
                fontFamily: "Gotham",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
            filled: true,
            fillColor: const Color(0xfff1f3f5),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none))),
        maxLines: 1,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
