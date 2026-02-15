import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Replacing the URL
  final String baseUrl = "http://10.0.2.2:5000";

  Future<double> predict(double term1, double term2) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "term1": term1,
        "term2": term2,
      }),
    );

    final data = jsonDecode(response.body);
    return data["predicted_score"];
  }
}
