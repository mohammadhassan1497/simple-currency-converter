import 'package:http/http.dart' as http;

const String domain =
    'https://v6.exchangerate-api.com/v6/024ba5b15d79536c5abfd7f1';

class HTTPRequest {
  static Future get(String route) async {
    final response = await http.get(Uri.parse('$domain$route'));
    return response;
  }
}
