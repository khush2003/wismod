import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wismod/modules/home/controller/home_controller.dart';
import 'package:wismod/modules/home/views/filter_options.dart';
import 'package:wismod/utils/app_utils.dart';

import '../../../routes/routes.dart';
import '../../../theme/global_widgets.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeController = Get.put(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sideWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                child: OutlineButtonMedium(
                  onPressed: () => Get.toNamed(Routes.createEvent),
                  child: const Text('Create Event'),
                ),
              ),
              addVerticalSpace(16),
              PrimaryButtonMedium(
                  child: const Text("Log Out (Checking)"),
                  onPressed: () => homeController.logOut()),
              // TODO: ListView for eventcards and mapping them to incoming values and use a builder function instead
              EventCard(
                description: 'Loreum ipsum dolor sit amet consectetur',
                imageUrl:
                    'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                eventDate: DateTime.now(),
                category: 'Competition',
                eventOwner: 'John Hotfoot',
                id: 5,
                title: 'KMUTT BioHackathon',
                upvotes: 4,
              ),
              addVerticalSpace(24),
              EventCard(
                description:
                    'Welcome, come, join, have fuuuuuuuuuuunnunununun KMUTT is the best join me my friends we will enjoy our life and not write code.',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbmT5f6Uqu-p0tDftdiTuI8u187X2fyvoUXkcKcWz&s',
                eventDate: DateTime.now(),
                category: 'Hanging Out',
                eventOwner: 'Khush Agarwal',
                id: 3,
                title: "Let's play a Board Game",
                upvotes: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String category;
  final String title;
  final int upvotes;
  final String? imageUrl;
  final DateTime? eventDate;
  final String eventOwner;
  final String? description;
  final int id;
  const EventCard(
      {super.key,
      required this.category,
      required this.title,
      required this.upvotes,
      this.imageUrl,
      this.eventDate,
      required this.eventOwner,
      this.description,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
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
                  '#$category',
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
                    Text(title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('$upvotes upvotes',
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
                addVerticalSpace(20),
                if (imageUrl != null)
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(imageUrl!, fit: BoxFit.cover)),
                addVerticalSpace(20),
                if (eventDate != null)
                  Text(
                    'Date: ${formatDate(eventDate!)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                addVerticalSpace(20),
                Text('Event Owner: $eventOwner',
                    style: Theme.of(context).textTheme.bodyMedium),
                addVerticalSpace(20),
                if (description != null)
                  Text('Details: $description',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3),
              ]),
              addVerticalSpace(20),
              OutlineButtonMedium(
                  child: const Text("Read More"),
                  onPressed: () {
                    // Todo: Function to go to event detail page
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
          // TODO: Change to Get.toNamed() and create Route
          Get.to(
            FilterOptionsView(),
            transition: Transition.rightToLeft,
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
