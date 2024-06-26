import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorData {
  final double temperature;
  final double humidity;

  SensorData({required this.temperature, required this.humidity});
}

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  late DatabaseReference _databaseReference;
  SensorData? _latestData;

  @override
  void initState() {
    super.initState();
    _initFirebase();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.ref();
    _listenForData();
  }

  void _listenForData() {
    _databaseReference.child('temperature').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double temperature = _extractValue(event);
        setState(() {
          _latestData = SensorData(
              temperature: temperature, humidity: _latestData?.humidity ?? 0);
        });
      }
    });

    _databaseReference.child('humidity').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double humidity = _extractValue(event);
        setState(() {
          _latestData = SensorData(
              temperature: _latestData?.temperature ?? 0, humidity: humidity);
        });
      }
    });
  }

  double _extractValue(DatabaseEvent event) {
    Map<dynamic, dynamic>? data =
        event.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      return data.values.last.toDouble(); // Get the last value from the list
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: const Text(
          "Hive Temperature & Humidity",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 249, 204, 3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_latestData != null)
                _buildCircularUI(_latestData!.temperature, 'Temperature'),
              const SizedBox(height: 20),
              if (_latestData != null)
                _buildCircularUI(_latestData!.humidity, 'Humidity'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularUI(double value, String title) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 249, 204, 3),
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$value',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SensorPage()),
            );
          },
          child: const Text('Open Sensor Page'),
        ),
      ),
    );
  }
}
