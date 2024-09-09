// import 'package:auth0_flutter/auth0_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class AuthService {
//   static final AuthService _instance = AuthService._internal();
//   factory AuthService() => _instance;
//   AuthService._internal();

//   final Auth0 auth0 = Auth0(
//     dotenv.env['AUTH0_DOMAIN']!,
//     dotenv.env['AUTH0_CLIENT_ID']!,
//   );

//   Future<void> login() async {
//     print('Logging in...');
//     try {
//       final result = await auth0.webAuthentication().login();
//       // Save the result for future use
//     } catch (e) {
//       print('Login failed: $e');
//     }
//   }

//   Future<void> logout() async {
//     print('Logging out...');
//     try {
//       await auth0.webAuthentication().logout();
//     } catch (e) {
//       print('Logout failed: $e');
//     }
//   }
// }
