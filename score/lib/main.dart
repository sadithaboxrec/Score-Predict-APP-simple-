import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final term1Controller = TextEditingController();
  final term2Controller = TextEditingController();
  String result = "";

  Future<void> predictScore() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/predict"), // Android emulator
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "term1": double.parse(term1Controller.text),
        "term2": double.parse(term2Controller.text),
      }),
    );

    final data = jsonDecode(response.body);

    setState(() {
      result = "Predicted Score: ${data["predicted_score"]}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Score Predictor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: term1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Term 1 Score"),
            ),
            TextField(
              controller: term2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Term 2 Score"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictScore,
              child: const Text("Predict"),
            ),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
