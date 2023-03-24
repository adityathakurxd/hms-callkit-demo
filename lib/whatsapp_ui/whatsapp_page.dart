import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:hms_callkit/app_navigation/app_router.dart';
import 'package:hms_callkit/app_navigation/navigation_service.dart';
import 'package:hms_callkit/utility_functions.dart';

import 'chats_list.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key});

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  final tabColor = const Color.fromRGBO(0, 167, 131, 1);
  final appBarColor = const Color.fromRGBO(31, 44, 52, 1);
  @override
  void initState() {
    super.initState();
    listenerEvent(onEvent);
    tabBarController = TabController(length: 3, vsync: this);
  }

  Future<void> listenerEvent(Function? callback) async {
    try {
      FlutterCallkitIncoming.onEvent.listen((event) async {
        print(' HMSSDK HOME: $event');
        switch (event!.event) {
          case Event.ACTION_CALL_INCOMING:
            break;
          case Event.ACTION_CALL_START:
            break;
          case Event.ACTION_CALL_ACCEPT:
            var data = event.body;
            String authToken = data["extra"]["authToken"];
            String userName = data["nameCaller"];
            bool res = await getPermissions();
            if (res) {
              startOutGoingCall();
              NavigationService.instance
                  .pushNamed(AppRoute.callingPage, args: authToken);
            }
            break;
          case Event.ACTION_CALL_DECLINE:
            break;
          case Event.ACTION_CALL_ENDED:
            break;
          case Event.ACTION_CALL_TIMEOUT:
            break;
          case Event.ACTION_CALL_CALLBACK:
            break;
          case Event.ACTION_CALL_TOGGLE_HOLD:
            break;
          case Event.ACTION_CALL_TOGGLE_MUTE:
            break;
          case Event.ACTION_CALL_TOGGLE_DMTF:
            break;
          case Event.ACTION_CALL_TOGGLE_GROUP:
            break;
          case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
            break;
          case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
            break;
        }
        if (callback != null) {
          callback(event.toString());
        }
      });
    } on Exception {
      print("HMSSDK Exception");
    }
  }

  onEvent(event) {
    if (!mounted) return;
    setState(() {
      onEventLogs += "${event.toString()}\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: const Text(
                      'Create Group',
                    ),
                    onTap: () {})
              ],
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: [
            ChatListScreen(),
            const Text('Status Contact Screen'),
            const Text('Calls')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              // Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else {
              // File? pickedImage = await pickImageFromGallery(context);
              // if (pickedImage != null) {
              //   Navigator.pushNamed(
              //     context,
              //     ConfirmStatusScreen.routeName,
              //     arguments: pickedImage,
              //   );
              // }
            }
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
