import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> checkUserLoggedIn() async {
  const String authenticationUrl = 'http://127.0.0.1:8000/api/check_authentication/';

  try {
    final response = await http.get(Uri.parse(authenticationUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['authenticated'] ?? false;
    } else {
      // Handle authentication check error
      return false;
    }
  } catch (error) {
    // Handle network or other errors
    return false;
  }
}
