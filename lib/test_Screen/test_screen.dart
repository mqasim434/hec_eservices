// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class UserListScreen extends StatefulWidget {
//   @override
//   _UserListScreenState createState() => _UserListScreenState();
// }
//
// class _UserListScreenState extends State<UserListScreen> {
//   Future<List<dynamic>> fetchUsers(String cnic) async {
//     final response = await http.get(Uri.parse('YOUR_API_ENDPOINT/user/$cnic'));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data;
//     } else {
//       throw Exception('Failed to load user data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String cnic = "12345"; // Replace with the CNIC you want to search
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: fetchUsers(cnic),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Loading indicator while data is fetched
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data.isEmpty) {
//             return Text('No users found');
//           } else {
//             // Display the list of users
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 final user = snapshot.data[index];
//                 return ListTile(
//                   title: Text(user['name']),
//                   subtitle: Text(user['email']),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
//
//
//

