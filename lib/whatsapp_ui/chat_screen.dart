import 'package:flutter/material.dart';
import 'package:hms_callkit/whatsapp_ui/utils/colors.dart';
import 'package:hms_callkit/whatsapp_ui/utils/user_data.dart';

import '../app_navigation/app_router.dart';
import '../app_navigation/navigation_service.dart';
import '../hmssdk/join_service.dart';
import '../utility_functions.dart';

class ChatScreen extends StatelessWidget {
  UserData userData;
  ChatScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        centerTitle: false,
        leadingWidth: 20,
        title: Row(
          children: [
            const Icon(
              Icons.account_circle,
              size: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              userData.numberOfUser,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.grey),
            onPressed: () async {
              await getPermissions();
              //Enter the tokenEndPoint, role and userId here
              //TODO: CLEAR OUT DATA
              String? authToken = await getAuthToken(
                  roomId: "641053ff4f410525264f060c",
                  role: "host",
                  tokenEndpoint:
                      "https://prod-in2.100ms.live/hmsapi/aadi.app.100ms.live/api/token",
                  userId: "USER${userData.numberOfUser}");
              //Checking whether authentication token is null or not
              if (authToken != null) {
                call(
                    receiverFCMToken: userData.fcmTokenOfUser,
                    authToken: authToken);

                NavigationService.instance.pushNamedIfNotCurrent(
                    AppRoute.previewPage,
                    args: authToken);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Auth token is null")));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.grey),
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
                    'View contact',
                  ),
                  onTap: () {})
            ],
          ),
        ],
      ),
    );
  }
}
