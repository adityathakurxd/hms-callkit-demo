import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hms_callkit/whatsapp_ui/chat_page.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _postStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children:
                  snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                // PostData.fromMap(snapshot.data() as Map<String, dynamic>);
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              numberOfUser: data['number'],
                              fcmTokenOfUser: data['token'],
                            )));
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                        title: Text(data['number']),
                        subtitle: Row(children: const [
                          Icon(
                            Icons.check,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("You: Last message")
                        ]),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
