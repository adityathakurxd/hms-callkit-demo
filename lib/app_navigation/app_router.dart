//Package imports

import 'package:flutter/material.dart';
import 'package:hms_callkit/home_page.dart';
import 'package:hms_callkit/hmssdk/meeting_page.dart';
import 'package:hms_callkit/hmssdk/preview_page.dart';
import 'package:hms_callkit/receive_call.dart';
import 'package:hms_callkit/whatsapp_ui/chat_screen.dart';
import 'package:hms_callkit/whatsapp_ui/login_page.dart';
import 'package:hms_callkit/whatsapp_ui/utils/user_data.dart';
import 'package:hms_callkit/whatsapp_ui/whatsapp_page.dart';

class AppRoute {
  static const homePage = '/home_page';

  static const callingPage = '/meeting_page';
  static const previewPage = '/preview_page';
  static const receiveCallPage = '/receive-call-page';
  static const whatsappLogin = '/whatsapp_login';
  static const whatsappHome = '/whatsapp_home';
  static const whatsappChat = '/whatsapp_chat';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (_) => const HomePage(), settings: settings);
      case callingPage:
        return MaterialPageRoute(
            builder: (_) => MeetingPage(
                  authToken: settings.arguments as String?,
                  userName: 'Test User',
                ),
            settings: settings);
      case previewPage:
        return MaterialPageRoute(
            builder: (_) => PreviewPage(
                  authToken: settings.arguments as String?,
                  userName: 'Test User',
                ),
            settings: settings);
      case receiveCallPage:
        return MaterialPageRoute(
            builder: (_) => ReceiveCall(
                callKitParams: settings.arguments as Map<String, dynamic>));
      case whatsappLogin:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(), settings: settings);
      case whatsappHome:
        return MaterialPageRoute(
            builder: (_) => const WhatsAppScreen(), settings: settings);
      case whatsappChat:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  userData: settings.arguments as UserData,
                ),
            settings: settings);
      default:
        return null;
    }
  }
}
