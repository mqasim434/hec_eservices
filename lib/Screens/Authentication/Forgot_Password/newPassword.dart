import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/Authentication/signIn.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:http/http.dart' as http;
import '../../Navbar_Screens/profile.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({required this.email});
  String email;

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String newPassword = "";
  String confirmPassword = "";
  String errorMessage = "";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  void resetPassword() async {
    // Validate the password length (6 digits)
    if (newPassword.length < 6) {
      setState(() {
        errorMessage = "Password must be 6 digits long.";
      });
      return;
    }

    // Check if the passwords match
    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = "Passwords do not match.";
      });
      return;
    }

    print(widget.email.toString());
    var response = await http.patch(
        Uri.parse('$baseUrl/updatePassword/${widget.email.toString()}'),
        body: {
          'password': newPassword,
          'confirmPassword': newPassword,
        });
    print(response.body);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Password Reset Successful"),
            content: const Text("Your password has been reset successfully."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                        (route) => false, // This line clears the stack
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: "New Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  newPassword = value;
                  errorMessage = "";
                });
              },
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: !isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: toggleConfirmPasswordVisibility,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                  errorMessage = "";
                });
              },
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: resetPassword,
              child: const Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
