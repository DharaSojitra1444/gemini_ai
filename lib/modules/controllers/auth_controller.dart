import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../main.dart';

class AuthController extends GetxController{

  // Future<void> signUpWithEmail(String email) async {
  //   final response = await supabase.auth.signUp(email: "demo123@yopmail.com", options: {
  //
  //     'sendVerificationEmail': false, // Set to true if you want to send email verification
  //   }, password: '');
  //
  //   if (response.error != null) {
  //     debugPrint("----1-----");
  //     // Handle error
  //     print(response.error!.message);
  //   } else {
  //     debugPrint("----e-----");
  //     // Signup successful, proceed with sending OTP
  //     // You can trigger sending OTP through email or other means here
  //   }
  // }


 // Future<void> verifyOTP(String email, String otp) async {
 //   final response = await supabase.auth.verifyOTP("demo123@yopmail.com", "");
 //
 //   if (response.error != null) {
 //     // Handle error
 //     print(response.error!.message);
 //   } else {
 //     // OTP verification successful, proceed with login or other actions
 //   }
 // }
 //
 // Future<void> loginWithEmailAndOTP(String email, String otp) async {
 //   final response = await supabase.auth.signIn(
 //     email: email,
 //     password: otp, // OTP is used as the password
 //   );
 //
 //   if (response.error != null) {
 //     // Handle error
 //     print(response.error!.message);
 //   } else {
 //     // Login successful, proceed with user session management
 //   }
 // }


}