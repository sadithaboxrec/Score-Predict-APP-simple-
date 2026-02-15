import 'dart:convert';
import 'package:flutter/material.dart';
import 'services/api_service.dart';


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

  final ApiService apiService = ApiService();

  final term1Controller = TextEditingController();
  final term2Controller = TextEditingController();
  String result = "";

Future<void> predictScore() async {
  final prediction = await apiService.predict(
    double.parse(term1Controller.text),
    double.parse(term2Controller.text),
  );

  setState(() {
    result = "Predicted Score: $prediction";
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
