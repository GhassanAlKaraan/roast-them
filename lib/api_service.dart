import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<String> makeApiCall(String input) async {
    String result = "Bad Input";
    if (input.isEmpty) return result;

    final url = Uri.parse(
        'https://api.forgeai.com/v1/apps/666811571fdb5301fdc33434/view/run');
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': 'YOUR_API_KEY'
    };
    final body = jsonEncode({
      "user_inputs": {
        "Find_my_Spirit_Animal_7": {"value": input}
      }
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        result = jsonResponse['user_outputs']['Final_Text_Output_5']['value'];

        return result;
      } else {
        result = 'Sorry, Http Error Code:${response.statusCode}';
        return result;
      }
    } catch (e) {
      result = 'Error: $e';
      return result;
    }
  }
}
