import 'package:http/http.dart' as http;
import '../logger_config.dart';

Future<void> logout() async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/logout/'), 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Logout was successful
      // Clear user data, tokens, or navigate to the login screen
    } else {
      // Handle error (e.g., unable to logout)
      logger.warning('Logout failed. Error: ${response.body}');
    }
  } catch (error) {
    // Handle unexpected errors
    logger.warning('Unexpected error during logout: $error');
  }
}

