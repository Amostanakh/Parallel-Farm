// // otp_service.dart
// import 'package:firebase_auth/firebase_auth.dart';

// class OTPService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId;

//   Future<void> verifyPhoneNumber(String phoneNumber) async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String verificationId, int resendToken) async {
//         // The code has been sent to the user's phone.
//         _verificationId = verificationId;
//         print("The verification code has been sent to the user's phone.");
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//         print("The verification code has expired. Please request a new one.");
//       },
//     );
//   }

//   Future<void> verifyCode(String smsCode) async {
//     // Create a PhoneAuthCredential with the provided verification ID and SMS code
//     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: _verificationId,
//       smsCode: smsCode,
//     );

//     // Sign in (or link) the user with the credential
//     await _auth.signInWithCredential(credential);
//   }
// }
