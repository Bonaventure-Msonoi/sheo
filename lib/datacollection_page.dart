import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SensorData {
  final double temperature;
  final double humidity;

  SensorData({
    required this.temperature,
    required this.humidity,
  });
}

class ModelOutput {
  final String recommendations;

  ModelOutput({
    required this.recommendations,
  });
}

class DataCollectionPage extends StatefulWidget {
  @override
  _DataCollectionPageState createState() => _DataCollectionPageState();
}

class _DataCollectionPageState extends State<DataCollectionPage> {
  List<SensorData> sensorData = [];

  void collectAndPreprocessData() {
    // Collect data from simulated sensors
    SensorData newData = collectSensorData();
    print('Collected Data: $newData');

    // Preprocess the collected data
    SensorData preprocessedData = preprocessData(newData);
    print('Preprocessed Data: $preprocessedData');

    // Store the preprocessed data
    setState(() {
      sensorData.add(preprocessedData);
    });

    // Feed preprocessed data to the model for analysis and recommendations
    ModelOutput modelOutput = analyzeData(preprocessedData);
    print('Model Recommendations: ${modelOutput.recommendations}');

    // Make prediction request with CSV data
    makePredictionRequest();
  }

  SensorData collectSensorData() {
    return SensorData(
      temperature: 22.7,
      humidity: 43.0,
    );
  }

  SensorData preprocessData(SensorData data) {
    // Implement data preprocessing logic if needed
    return data;
  }

  ModelOutput analyzeData(SensorData data) {
    return ModelOutput(
      recommendations: "Adjust thermostat settings to save energy.",
    );
  }

  Future<void> makePredictionRequest() async {
    final url = Uri.parse('http://192.168.43.119:5000/predict');

    // Example CSV data (replace with your actual data)
    final csvData =
        'date,t1,rh_1,t2,rh_2,t3,rh_3,t4,rh_4,t5,rh_5,t7,rh_7,t8,rh_8,t9,rh_9,t_out\n'
        '2023-01-01 00:00:00,20,40,22,45,23,50,21,42,25,48,26,47,23,49,22,46,10\n'
        '2023-01-01 01:00:00,21,42,23,46,24,48,22,43,26,50,27,49,24,50,23,47,8\n';

    final response = await http.post(
      url,
      body: {'file': csvData},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Predictions: ${data['predictions']}');
      // Display model recommendations and allow user actions
      displayRecommendations(ModelOutput(recommendations: data['predictions']));
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  void displayRecommendations(ModelOutput modelOutput) {
    // Implement UI to display recommendations and actions
    // e.g., show a dialog with recommendations and settings adjustments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Collection, Preprocessing, and Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: collectAndPreprocessData,
              child: Text('Collect, Preprocess, and Predict'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: sensorData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:
                        Text('Temperature: ${sensorData[index].temperature.toString()}°C'),
                    subtitle: Text('Humidity: ${sensorData[index].humidity.toString()}%'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DataCollectionPage(),
  ));
}
