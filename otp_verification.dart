import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:krewsup/app/auth/presentation/pages/pop_up_success.dart';
import 'package:krewsup/core/theme/button.dart';
import 'package:krewsup/app/Home/features/ProfilePage/presentation/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationPage({super.key, required this.phoneNumber});
  static route(String phoneNumber) => MaterialPageRoute(
        builder: (context) => OTPVerificationPage(phoneNumber: phoneNumber),
      );

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> otpControllers =
  List.generate(6, (index) => TextEditingController());

  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController(); // OTP controller
  final supabase = Supabase.instance.client; // Supabase client instance

  @override
  void dispose() {
    otpController.dispose(); // Dispose OTP controller
    super.dispose();
  }

 Future<void> verifyOtp() async {
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => PopUpSuccess(),
     ),
   );
  // if (formKey.currentState!.validate()) {
  //   final phoneNumber = widget.phoneNumber;
  //   final otp = otpController.text; // Declare otp only once
  //   if (otp == "123456") {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("OTP verified successfully.")),
  //     );
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ProfileSetupPage(phoneNumber: phoneNumber),
  //       ),
  //     );
  //     return; // Exit the function if OTP is verified
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Invalid OTP. Please try again.")),
  //     );
  //     return; // Exit the function if OTP is invalid
  //   }
  //
  //   final response = await http.post(
  //     Uri.parse('http://localhost:5000/api/verify-otp'),
  //     body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //
  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("OTP verified successfully.")),
  //     );
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ProfileSetupPage(phoneNumber: phoneNumber),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to verify OTP: ${response.body}')),
  //     );
  //   }
  // }
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

                const SizedBox(height: 20),
                Text(
                  "We Have Sent A Verification Code To",
                  style: TextStyle(
                    color: Color(0xFF4A978F), // Set text color to #4A978F
                    fontFamily: 'Arial Rounded MT Bold', // Set font family
                    fontSize: 16, // Set font size
                    fontWeight: FontWeight.bold, // Set font weight
                    height: 18.52 / 16, // Equivalent to line-height: 18.52px
                    letterSpacing: 0.05, // Set letter spacing

                    decorationColor: Color(0xFF4A978F), // Match underline color to text
                    decorationThickness: 1.5, // Optional: Adjust underline thickness
                    decorationStyle: TextDecorationStyle.solid, // Underline style
                  ),
                  textAlign: TextAlign.left, // Align text to the left
                ),
                const SizedBox(height: 20),
                Text(
                  "+91-1234567890",
                  style: TextStyle(
                    color: Color(0xFF4A978F), // Set text color to #4A978F
                    fontFamily: 'Arial Rounded MT Bold', // Set font family
                    fontSize: 16, // Set font size
                    fontWeight: FontWeight.bold, // Set font weight
                    height: 18.52 / 16, // Equivalent to line-height: 18.52px
                    letterSpacing: 0.05, // Set letter spacing

                    decorationColor: Color(0xFF4A978F), // Match underline color to text
                    decorationThickness: 1.5, // Optional: Adjust underline thickness
                    decorationStyle: TextDecorationStyle.solid, // Underline style
                  ),
                  textAlign: TextAlign.left, // Align text to the left
                ),

                // OTP Input
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 46),
                //   child: TextFormField(
                //     controller: otpController,
                //     keyboardType: TextInputType.number,
                //     decoration: const InputDecoration(
                //       labelText: 'Enter 6-digit OTP',
                //     ),
                //     maxLength: 6, // Limit to 6 digits
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter OTP';
                //       } else if (value.length != 6) {
                //         return 'OTP must be 6 digits';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 46),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40, // Width of each box
                        height: 40, // Height of each box
                        child: TextFormField(
                          controller: otpControllers[index], // Individual controllers
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center, // Center-align the input
                          maxLength: 1, // Restrict to 1 character per box
                          decoration: InputDecoration(
                            counterText: '', // Hide the character counter
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey), // Default border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue), // Focused border
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus(); // Move to next box
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus(); // Move to previous box
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 60),

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn’t Get The OTP? ",
                          style: TextStyle(
                            color: Color(0xFF4A978F), // Main color for "Didn't Get The OTP?"
                            fontSize: 14,
                            fontFamily: 'Arial Rounded MT Bold',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.05,
                          ),
                        ),
                        TextSpan(
                          text: "Resend OTP",
                          style: TextStyle(
                            color: Colors.white, // White color for "Resend OTP"
                            fontSize: 14,
                            fontFamily: 'Arial Rounded MT Bold',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.05,
                            // decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle Resend OTP action here
                              // _resendOtp();
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                // OTP Verification Button
                AuthGradientButton(
                  buttonText: "Enter",
                  onPressed: verifyOtp, // Call the verifyOtp function
                  width: 300.0,
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
