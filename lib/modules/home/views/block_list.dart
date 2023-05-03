import 'package:flutter/material.dart';
import 'package:wismod/utils/app_utils.dart';

class BlockListView extends StatelessWidget {
  const BlockListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Block list",
        style: TextStyle(
            fontFamily: "Gotham",
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black),
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(children: const [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: BlockedPerson(
                    personPortraitUrl:
                        'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80',
                    personName: 'Phongsaphak Fongsamut',
                    blockId: 5,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: BlockedPerson(
                    personPortraitUrl:
                        'https://pbs.twimg.com/media/EQn2_t5U8AITpgl.jpg',
                    personName: 'Arthun Jeezsprout',
                    blockId: 2,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

class BlockedPerson extends StatelessWidget {
  final String? personPortraitUrl;
  final String personName;

  final int blockId;

  const BlockedPerson(
      {super.key,
      this.personPortraitUrl,
      required this.personName,
      // required this.latestChat,
      required this.blockId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).navigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(107, 41, 237, 1),
              offset: Offset(0, 4),
              blurRadius: 6),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(sideWidth),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (personPortraitUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          personPortraitUrl!,
                          // Image size adjustment here
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                addHorizontalSpace(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        personName,
                        style: const TextStyle(
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 22),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      addVerticalSpace(5),
                    ],
                  ),
                ),
                //Icon
                const CancelBlock(),
              ],
            ),
            addVerticalSpace(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// double _volume = 0.0;

class CancelBlock extends StatelessWidget {
  const CancelBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cancel_rounded),
      iconSize: 50.0,
      tooltip: 'Remove from block list',
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        // todo
      },
    );
  }
}
