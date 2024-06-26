import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({required this.latitude, required this.longitude});
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late DatabaseReference _databaseReference;
  LocationData? _latestData;

  @override
  void initState() {
    super.initState();
    _initFirebase();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.reference();
    _listenForData();
  }

  void _listenForData() {
    _databaseReference.child('atitude').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double latitude = _extractValue(event);
        setState(() {
          _latestData = LocationData(
            latitude: latitude,
            longitude: _latestData?.longitude ?? 0,
          );
        });
      }
    });

    _databaseReference.child('longitude').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double longitude = _extractValue(event);
        setState(() {
          _latestData = LocationData(
            latitude: _latestData?.latitude ?? 0,
            longitude: longitude,
          );
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
          "GPS Location",
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
                _buildCircularUI(_latestData!.latitude, 'Atitude'),
              const SizedBox(height: 20),
              if (_latestData != null)
                _buildCircularUI(_latestData!.longitude, 'Longitude'),
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
              MaterialPageRoute(builder: (context) => const LocationPage()),
            );
          },
          child: const Text('Open Location Page'),
        ),
      ),
    );
  }
}
