import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krewsup/core/injectable/injectable.dart';
import 'package:krewsup/core/logger/talker.logger.dart';
import 'package:krewsup/core/theme/app_pallete.dart';
import 'package:krewsup/core/theme/button.dart';
import 'package:krewsup/app/auth/presentation/bloc/auth_bloc.dart';
import 'package:krewsup/app/auth/presentation/pages/otp_verification.dart';
import 'package:krewsup/app/auth/presentation/widgets/phone_auth_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  String fullPhoneNumber = '';

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/kpmain.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/full_kutty_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 46),
                    child: Text(
                      "Enter your number",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              AppPallete.lightBlueColor,
                              AppPallete.darkBlueColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(0, 0, 300, 40)),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                PhoneNumberInput(
                  onPhoneNumberChanged: (phoneNumber) {
                    setState(() {
                      fullPhoneNumber = phoneNumber;
                    });
                    getIt.get<MyLogger>().instance.info(fullPhoneNumber);
                  },
                  controller: phoneNumberController,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 60),
                BlocListener<AuthBloc, AuthState>(
                  listener: (prev, next) {
                    if (next is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to sign up.")),
                      );
                    }
                  },
                  child: AuthGradientButton(
                    buttonText: "Confirm",
                    onPressed: () async {
                      Navigator.push(
                        context,
                        OTPVerificationPage.route(fullPhoneNumber),
                      );
                      // if (formKey.currentState!.validate()) {
                      //   final response = await http.post(
                      //     Uri.parse('http://localhost:5000/api/register'),
                      //     body: jsonEncode({'phoneNumber': fullPhoneNumber}),
                      //     headers: {'Content-Type': 'application/json'},
                      //   );
                      //
                      //   print('Response status: ${response.statusCode}');
                      //   print('Response body: ${response.body}');
                      //
                      //   if (response.statusCode == 200) {
                      //     // Navigate to OTPVerificationPage and pass the phone number
                      //     Navigator.push(
                      //       context,
                      //       OTPVerificationPage.route(fullPhoneNumber),
                      //     );
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //           content: Text(
                      //               'Failed to register: ${response.body}')),
                      //     );
                      //   }
                      // }
                    },
                    width: 300.0,
                  ),
                ),
                const SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
