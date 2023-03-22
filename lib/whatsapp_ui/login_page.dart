import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hms_callkit/whatsapp_ui/utils/custom_button.dart';
import 'package:hms_callkit/whatsapp_ui/utils/firestore_service.dart';

import '../app_navigation/app_router.dart';
import '../app_navigation/navigation_service.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            country = country;
          });
        });
  }

  // void sendPhoneNumber() {
  //   String phoneNumber = phoneController.text.trim();
  //   if (country != null && phoneNumber.isNotEmpty) {
  //     ref
  //         .read(authControllerProvider)
  //         .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
  //   } else {
  //     showSnackBar(context: context, content: 'Fill out all the fields');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('WhatsApp will need to verify your phone number.'),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: pickCountry,
                  child: const Text('Pick Country'),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: 'phone number',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.6),
                SizedBox(
                  width: 90,
                  child: CustomButton(
                    onPressed: () async {
                      if (phoneController.value.text.isNotEmpty) {
                        String? token =
                            await FirebaseMessaging.instance.getToken();
                        await FirestoreService().updateUserData(
                            token ?? "TokenNotFound",
                            phoneController.value.text.toString());

                        NavigationService.instance
                            .pushNamedAndRemoveUntil(AppRoute.whatsappHome);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Please enter a valid phone number!")));
                      }
                    },
                    text: 'NEXT',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
