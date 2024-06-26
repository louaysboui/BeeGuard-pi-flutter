import 'package:flutter/material.dart';
import 'package:flutter_formation/Albums/alertTfetch.dart';

class Alerttemp extends StatelessWidget {
  const Alerttemp({super.key});

  @override
  Widget build(BuildContext context) {
    late Future<AlertT> futureAlertT;
    futureAlertT = fetchAlertT();
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 255, 235, 59),
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Temperature Alert',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
              height: 10), // Add spacing between text and the next widget
          Expanded(
            child: FutureBuilder<AlertT>(
              future: futureAlertT,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final double temperature =
                      snapshot.data!.temperature;
                  if (temperature > 40.0) {
                    return Center(
                      child: Text(
                        'The temperature is high: $temperature',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'The temperature is not high.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  );
                }

                // By default, show a loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
