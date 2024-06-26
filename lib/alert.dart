import 'package:flutter/material.dart';
import 'package:flutter_formation/alerttemp.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(180, 255, 235, 59),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEB50B), // Yellow color #eeb50b
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'BeeGuard Alerts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0, // Adjust the font size as needed
              color: Colors.black, // Customize the text color
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAlertCard(
                title: 'High Temperature Alert',
                icon: Icons.whatshot,
                color: const Color.fromARGB(255, 0, 0, 0),
                context: context,
              ),
              const SizedBox(height: 16), // Add spacing between the alerts
              // Commented out the other alerts
              _buildAlertCard(
                title: 'Heavy Rain Warning',
                icon: Icons.beach_access,
                color: const Color.fromARGB(255, 0, 0, 0),
                context: context,
              ),
              const SizedBox(height: 16), // Add spacing between the alerts
              _buildAlertCard(
                title: 'Hive Position Changing',
                icon: Icons.location_on,
                color: const Color.fromARGB(255, 0, 0, 0),
                context: context,
              ),
              const SizedBox(height: 16), // Add spacing between the alerts
              _buildAlertCard(
                title: 'Threat Alert',
                icon: Icons.warning,
                color: const Color.fromARGB(255, 0, 0, 0),
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required IconData icon,
    required Color color,
    required BuildContext context, // Pass the context
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 24), // Adjust padding
        leading: Icon(
          icon,
          color: Colors.white,
          size: 36,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onTap: () {
          // Navigate to the Alerttemp only when the title is "High Temperature Alert"
          if (title == 'High Temperature Alert') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Alerttemp()),
            );
          }
        },
      ),
    );
  }
}
