import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/Authentication/Forgot_Password/newPassword.dart';
import 'package:hec_eservices/Screens/Authentication/signIn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTPScreen extends StatefulWidget {

  OTPScreen({required this.otp,required this.email});
  String otp;
  String email;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredOTP = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('OTP Verification'),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PinCodeTextField(
                appContext: context,
                length: 4, // Length of the PIN or OTP
                onChanged: (value) {
                  setState(() {
                    enteredOTP = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (enteredOTP == widget.otp) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NewPasswordScreen(email: widget.email,)));
                } else {
                  // OTP is incorrect, show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid OTP. Please try again.'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
