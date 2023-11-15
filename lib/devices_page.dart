import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Collection',
      home: DevicesPage(),
    );
  }
}

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  double kitchenTemperature = 22.0;
  double kitchenHumidity = 50.0;
  double livingRoomTemperature = 24.0;
  double livingRoomHumidity = 45.0;
  double laundryRoomTemperature = 21.0;
  double laundryRoomHumidity = 55.0;
  double officeTemperature = 21.5;
  double officeHumidity = 40.0;
  double bathroomTemperature = 23.5;
  double bathroomHumidity = 55.0;
  double outsideTemperature = -5.0;
  double outsideHumidity = 20.0;
  double ironingRoomTemperature = 24.5;
  double ironingRoomHumidity = 50.0;
  double teenagerRoom2Temperature = 22.8;
  double teenagerRoom2Humidity = 42.0;
  double parentsRoomTemperature = 21.2;
  double parentsRoomHumidity = 47.0;

  bool isLightOn = false;
  double energyUsage = 31.0;

  String currentDateTime = '';

  List<String> collectedData = [];
  List<double> predictionResults = [];

  

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        isLightOn = !isLightOn;
      });
    });

    Timer.periodic(Duration(minutes: 2), (timer) {
      final now = DateTime.now();
      final isSummer =
          now.month >= DateTime.september && now.month <= DateTime.november;
      setState(() {
        kitchenTemperature = (isSummer ? 25 : 20) + Random().nextDouble() * 10;
        kitchenHumidity = 40 + Random().nextDouble() * 20;
        livingRoomTemperature = (isSummer ? 27 : 22) + Random().nextDouble() * 8;
        livingRoomHumidity = 35 + Random().nextDouble() * 15;
        laundryRoomTemperature = (isSummer ? 25 : 20) + Random().nextDouble() * 10;
        laundryRoomHumidity = 45 + Random().nextDouble() * 15;
        officeTemperature = (isSummer ? 25.5 : 20.5) + Random().nextDouble() * 10;
        officeHumidity = 35 + Random().nextDouble() * 15;
        bathroomTemperature = (isSummer ? 27.5 : 22.5) + Random().nextDouble() * 8;
        bathroomHumidity = 50 + Random().nextDouble() * 10;
        outsideTemperature = (isSummer ? 15 : -5) + Random().nextDouble() * 30;
        outsideHumidity = 10 + Random().nextDouble() * 60;
        ironingRoomTemperature = (isSummer ? 27.5 : 22.5) + Random().nextDouble() * 6;
        ironingRoomHumidity = 40 + Random().nextDouble() * 15;
        teenagerRoom2Temperature = (isSummer ? 25 : 22) + Random().nextDouble() * 10;
        teenagerRoom2Humidity = 45 + Random().nextDouble() * 15;
        parentsRoomTemperature = (isSummer ? 24 : 21.5) + Random().nextDouble() * 10;
        parentsRoomHumidity = 40 + Random().nextDouble() * 15;
        //added
        // Room1Temperature = (isSummer ? 24 : 21.5) + Random().nextDouble() * 10;
        // Room1Humidity = 40 + Random().nextDouble() * 15;
        // Room2Temperature = (isSummer ? 24 : 21.5) + Random().nextDouble() * 10;
        // Room2Humidity = 40 + Random().nextDouble() * 15;
        // Room3Temperature = (isSummer ? 24 : 21.5) + Random().nextDouble() * 10;
        // Room3Humidity = 40 + Random().nextDouble() * 15;
      });
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final formattedDateTime =
          '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';
      setState(() {
        currentDateTime = formattedDateTime;
      });
    });
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  void collectData() {
    String data = '''
Kitchen - Temperature: $kitchenTemperature°C, Humidity: $kitchenHumidity%
Living Room - Temperature: $livingRoomTemperature°C, Humidity: $livingRoomHumidity%
Laundry Room - Temperature: $laundryRoomTemperature°C, Humidity: $laundryRoomHumidity%
Office - Temperature: $officeTemperature°C, Humidity: $officeHumidity%
Bathroom - Temperature: $bathroomTemperature°C, Humidity: $bathroomHumidity%
Outside (North) - Temperature: $outsideTemperature°C, Humidity: $outsideHumidity%
Ironing Room - Temperature: $ironingRoomTemperature°C, Humidity: $ironingRoomHumidity%
Teenager Room 2 - Temperature: $teenagerRoom2Temperature°C, Humidity: $teenagerRoom2Humidity%
Parents Room - Temperature: $parentsRoomTemperature°C, Humidity: $parentsRoomHumidity%
Lights - Status: ${isLightOn ? 'On' : 'Off'}, Energy Usage: ${energyUsage.toStringAsFixed(1)} Wh
Date and Time - Current Time: $currentDateTime
    ''';

    collectedData.add(data);
  }

//predict from
Future<double?> predictFromData(String data) async {
  final Map<String, dynamic> requestData = {
    'kitchenTemperature': 25.0, // Replace with actual values
    'kitchenHumidity': 28.0,
    'livingRoomTemperature': 24.0,
    'livingRoomHumidity': 45.0,
    'laundryRoomTemperature': 32.0,
    'laundryRoomHumidity': 60.0,
    'officeTemperature': 27.0,
    'officeHumidity': 55.0,
    'bathroomTemperature': 29.0,
    'bathroomHumidity': 50.0,
    'outsideTemperature': 32.0,
    'outsideHumidity': 27.0,        
    'ironingRoomTemperature': 30.0,
    'ironingRoomHumidity': 25.0,
    'teenagerRoom2Temperature': 27.0,
    'teenagerRoom2Humidity': 20.0,
    'parentsRoomTemperature': 32.0,
    'parentsRoomHumidity': 23.0,
    'random1': 26.0,
    'random2': 28.0,
    'random3': 28.0,
    'random4': 25.0,
    'random5': 27.0,
    'random6': 32.0,
    'random7': 25.0,
    'energyUsage': 91.0,

  };

  try {
    final response = await http.post(
      Uri.parse('http://192.168.43.119:5000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      double prediction = result['prediction'];
      print('Prediction: $prediction');
      // setState(() {
      //   predictionResults.add(prediction);
      // });
       return prediction;
      
    } else {
      print('Failed to make a prediction. Status code: ${response.statusCode}');
      // Add error handling logic if needed
    }
  } catch (e) {
    print('Error during prediction: $e');
    // Handle other exceptions if needed
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Simulation'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RoomSensorCard(
                roomName: 'Kitchen',
                temperature: kitchenTemperature,
                humidity: kitchenHumidity,
              ),
              RoomSensorCard(
                roomName: 'Living Room',
                temperature: livingRoomTemperature,
                humidity: livingRoomHumidity,
              ),
              RoomSensorCard(
                roomName: 'Laundry Room',
                temperature: laundryRoomTemperature,
                humidity: laundryRoomHumidity,
              ),
              RoomSensorCard(
                roomName: 'Office',
                temperature: officeTemperature,
                humidity: officeHumidity,
              ),
              RoomSensorCard(
                roomName: 'Bathroom',
                temperature: bathroomTemperature,
                humidity: bathroomHumidity,
              ),
              RoomSensorCard(
                roomName: 'Outside (North)',
                temperature: outsideTemperature,
                humidity: outsideHumidity,
              ),
              RoomSensorCard(
                roomName: 'Ironing Room',
                temperature: ironingRoomTemperature,
                humidity: ironingRoomHumidity,
              ),
              RoomSensorCard(
                roomName: 'Teenager Room 2',
                temperature: teenagerRoom2Temperature,
                humidity: teenagerRoom2Humidity,
              ),
              RoomSensorCard(
                roomName: 'Parents Room',
                temperature: parentsRoomTemperature,
                humidity: parentsRoomHumidity,
              ),
              LightSensorCard(
                isLightOn: isLightOn,
                energyUsage: energyUsage,
              ),
              DateAndTimeCard(currentDateTime: currentDateTime),
              ElevatedButton(
                onPressed: () {
                  collectData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectedDataPage(collectedData, predictFromData),
                    ),
                  );
                },
                child: Text('Collect Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomSensorCard extends StatelessWidget {
  final String roomName;
  final double temperature;
  final double humidity;

  RoomSensorCard({
    required this.roomName,
    required this.temperature,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$roomName'),
            Text('Temperature: ${temperature.toStringAsFixed(1)}°C'),
            Text('Humidity: ${humidity.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}

class LightSensorCard extends StatelessWidget {
  final bool isLightOn;
  final double energyUsage;

  LightSensorCard({
    required this.isLightOn,
    required this.energyUsage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: isLightOn ? Colors.yellow : Colors.grey,
                  size: 32.0,
                ),
                SizedBox(width: 10.0),
                Text('Lights'),
              ],
            ),
            Text('Status: ${isLightOn ? 'On' : 'Off'}'),
            Text('Energy Usage: ${energyUsage.toStringAsFixed(1)} Wh'),
          ],
        ),
      ),
    );
  }
}

class DateAndTimeCard extends StatelessWidget {
  final String currentDateTime;

  DateAndTimeCard({
    required this.currentDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Date and Time'),
            Text('Current Time: $currentDateTime'),
          ],
        ),
      ),
    );
  }
}

class CollectedDataPage extends StatefulWidget {
  final List<String> collectedData;
  final Function predictFromData;

  CollectedDataPage(this.collectedData, this.predictFromData);

  @override
  _CollectedDataPageState createState() => _CollectedDataPageState();
}

class _CollectedDataPageState extends State<CollectedDataPage> {
  List<double?> predictionResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collected Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.collectedData.length,
              itemBuilder: (context, index) {
                final data = widget.collectedData[index];
                return ListTile(
                  title: Text('Data Entry ${index + 1}'),
                  subtitle: Text(data),
                  onTap: () async {
                    final result = await widget.predictFromData(data);
                    setState(() {
                      // Ensure the predictionResults list has enough elements
                      while (predictionResults.length <= index) {
                        predictionResults.add(null);
                      }
                      // Update the prediction result for the current index
                      predictionResults[index] = result;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                 // Send collected data to Flask application
                  for (String data in widget.collectedData) {
                    final result = await widget.predictFromData(data);
                    setState(() {
                      predictionResults.add(result);
                    });
                  }

                  // Add this print statement to debug
                  print('Prediction Results: $predictionResults');
                // Add any navigation or feedback after sending data if needed

                // Check if predictions are not null before navigating
                if (predictionResults.any((result) => result != null)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(predictionResults),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No valid prediction results'),
                      duration: Duration(seconds: 30),
                    ),
                  );
                }
              },
              child: Text('Predict'),
            ),
          ),
        ],
      ),
    );
  }
}

//results page
class ResultsPage extends StatelessWidget {
  final List<double?> predictionResults;

  ResultsPage(this.predictionResults);

  String getRecommendation(double? prediction) {
    if (prediction != null) {
      if (prediction < 5.0) {
        return "Energy consumption is at optimal status.";
      } else if (prediction >= 5.0 && prediction < 10.0) {
        return "Energy usage is at mid-range optimal level. For further energy efficiency, consider reducing device settings by 30%.";
      } else {
        return "Warning!! Energy consumption is expected to spike. Consider adjusting device settings to a more optimal level for energy saving.";
      }
    }
    return "No valid prediction result.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Results'),
      ),
      body: Column(
        children: [
          // Display prediction results and recommendations
          for (int i = 0; i < predictionResults.length; i++)
            ListTile(
              title: Text('Prediction ${i + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Result: ${predictionResults[i]?.toString() ?? "N/A"}'),
                  Text('Recommendation: ${getRecommendation(predictionResults[i])}'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
