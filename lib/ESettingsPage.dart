import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ESettingsPage extends StatefulWidget {
  @override
  _ESettingsPageState createState() => _ESettingsPageState();
}

class _ESettingsPageState extends State<ESettingsPage> {
  double temperature = 25.0; // Initial temperature value

  @override
  void initState() {
    super.initState();
    _loadThermostatSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esettings Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Thermostat Settings',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Temperature: $temperature °C',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Slider(
                  value: temperature,
                  min: 15.0,
                  max: 30.0,
                  onChanged: (value) {
                    setState(() {
                      temperature = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _saveThermostatSettings();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadThermostatSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedTemperature = prefs.getDouble('temperature') ?? 25.0;

    setState(() {
      temperature = savedTemperature;
    });
  }

  void _saveThermostatSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('temperature', temperature);

    // Optionally, you can show a confirmation message or navigate to another page.
    print('Temperature saved: $temperature');
  }
}
