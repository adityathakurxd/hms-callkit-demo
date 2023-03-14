import 'package:flutter/material.dart';
import 'package:hms_callkit/hmssdk/preview_page.dart';
import 'package:hms_callkit/whatsapp_ui/utils/colors.dart';

import '../hmssdk/join_service.dart';
import '../utility_functions.dart';

class ChatScreen extends StatelessWidget {
  String numberOfUser;
  String fcmTokenOfUser;
  ChatScreen(
      {super.key, required this.numberOfUser, required this.fcmTokenOfUser});

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
              numberOfUser,
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
                  roomId: "<>>c",
                  role: "host",
                  tokenEndpoint: "<>",
                  userId: "USER$numberOfUser");
              //Checking whether authentication token is null or not
              if (authToken != null) {
                call(receiverFCMToken: fcmTokenOfUser, authToken: authToken);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PreviewPage(
                          userName: "USER$numberOfUser",
                          authToken: authToken,
                        )));
                // NavigationService.instance.pushNamedIfNotCurrent(
                //     AppRoute.previewPage,
                //     args: authToken);
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
