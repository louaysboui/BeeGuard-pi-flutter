import 'package:flutter/material.dart';
import 'package:flutter_formation/alert.dart';
import 'package:flutter_formation/beecount.dart';
import 'package:flutter_formation/live.dart';
import 'package:flutter_formation/login_screen.dart';
import 'package:flutter_formation/production.dart';
import 'package:flutter_formation/profile.dart';
import 'package:flutter_formation/weather.dart';
// ignore: unused_import
import 'temperature.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xB4FFEB3B),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFBC02D),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          title: const Text(
            'Welcome to BeeGuard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0, // Adjust the font size as needed
              color: Colors.black, // Customize the text color
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: const BeekeepingScreen(),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}

class BeekeepingScreen extends StatelessWidget {
  const BeekeepingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // Add an image at the top of the interface
      Image.asset(
        'images/bee_live_image.jpg',
        height: 150.0,
        fit: BoxFit.fitWidth,
      ),
      // Add text at the bottom of the image
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
            onPressed: () {
              // Navigate to the live cam page when the text is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LiveCam()),
              );
            },
            child: const Text(
              'Tap Here For Live Cam',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 100,
          child: const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ImageAndButtonContainer(
                  image: AssetImage('images/temperature_image.png'),
                  buttonText: 'Temp & Hum',
                ),
                ImageAndButtonContainer(
                  image: AssetImage('images/weather_image.png'),
                  buttonText: 'Weather',
                ),
                ImageAndButtonContainer(
                  image: AssetImage('images/production_image.png'),
                  buttonText: 'Production',
                ),
                ImageAndButtonContainer(
                  image: AssetImage('images/bee_count_image.png'),
                  buttonText: 'GPS',
                ),
              ],
            ),
          ),
        ),
      ),
      // Add a big button at the bottom with text "Forum"
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle button tap
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 0, 0, 0), // Button background color
            ),
            child: const Text(
              'BeeGuard Forum',
              style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 251), // Text color
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ImageAndButtonContainer extends StatelessWidget {
  final ImageProvider image;
  final String buttonText;

  const ImageAndButtonContainer(
      {super.key, required this.image, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(109, 241, 174, 4),
      height: 200,
      width: 400,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image(image: image, height: 120, width: 150),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Check if the button is the "Temperature" button
              if (buttonText == 'Temp & Hum') {
                // Navigate to the Temperature page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SensorPage()),
                );
              } else {
                if (buttonText == 'Production') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductionPage()),
                  );
                } else {
                  if (buttonText == 'GPS') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocationPage()),
                    );
                  } else {
                    if (buttonText == 'Weather') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyWeather(),
                        ),
                      );
                    }
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255,
                    255), // Replace with the desired color for the text
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 2; // Set the initial index to 2 for the "Home" tab

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.yellow.shade700,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        // Handle navigation based on the selected tab index
        if (index == 0) {
          // Navigate to the "Alert" page or perform any action
        } else if (index == 1) {
          // Navigate to the "Profile" page or perform any action
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        } else if (index == 2) {
          // Navigate to the "Home" page or perform any action
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle profile icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlertPage()),
              );
            },
          ),
          label: 'Alert',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // Handle profile icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          label: 'Home',
        ),
      ],
    );
  }
}
