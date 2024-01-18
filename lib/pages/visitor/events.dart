import 'package:flutter/material.dart';
import 'package:test/backend/local_functions/event.dart';
// import 'package:test/backend/local_functions/util.dart';

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:test/util/navigate.dart';
import 'package:test/pages/visitor/event_view.dart';
import 'package:test/pages/visitor/register_new_event.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:test/util/user_type.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List _eventData = [];

  // Future<void> readJson() async {
  //   final String response =
  //       // await rootBundle.loadString('assets/dummy_event.json');
  //       await rootBundle.loadString('assets/save_registered_event_by_visitors.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _eventData = data["events"];
  //   });
  //   debugPrint(_eventData.toString());
  // }
  // Future<void> readJson() async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final file = File('${directory.path}/save_registered_event_by_visitors.json');

  //     // ファイルが存在するか確認
  //     if (!await file.exists()) {
  //       debugPrint("###################file not found");
  //       return;
  //     }

  //     // ファイルからJSONを読み込む
  //     String content = await file.readAsString();
  //     final data = jsonDecode(content);

  //     setState(() {
  //       _eventData = data["events"] ?? [];
  //     });

  //     debugPrint(_eventData.toString());
  //   } catch (e) {
  //     debugPrint("error occurred: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    loadEventListFromFile();
    // resetLocalEventList(UserType.visitor);
  }

  void loadEventListFromFile() {
    getEventListFromLocalFile(UserType.visitor).then((value) {
      // debugPrint('############### INIT EVENTS PAGE ##################');
      // debugPrint('$value');
      setState(() {
        _eventData = value;
      });
    });
  }

  Padding getSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SearchAnchor(
        isFullScreen: false,
        // viewLeading: const Icon(null),
        viewLeading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(_eventData.length, (index) {
            final String eventName = _eventData[index]['event_name'];
            return ListTile(
                title: Text(eventName),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    controller.closeView(eventName);
                  });
                });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: const BackButton(),
        title: const Text("Events"),
      ),
      body: Column(
        children: [
          getSearchBar(context),
          // const Flexible(
          //   child: FractionallySizedBox(
          //     heightFactor: 0.08,
          //   ),
          // ),
          // const Spacer(flex: 1),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              moveToPage(context, const RegisterNewEventPage()).then((_) {
                // debugPrint('################## push popped!!');
                loadEventListFromFile();
              });
            },
            child: const Text("register new event"),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            // flex: 100,
            child: Scrollbar(
              thickness: 15,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _eventData.length,
                  itemBuilder: (context, index) {
                    final String eventName = _eventData[index]['eventName'];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        // TODO: query event by event code
                        onPressed: () => moveToPage(
                            context, EventViewPage(eventCode: eventName)),
                        child: ListTile(
                          title: Text(eventName),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
