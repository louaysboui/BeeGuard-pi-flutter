import 'package:flutter/material.dart';
import 'package:flutter_formation/home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder image of the user
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'BroKeeper',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: BroKeeper@Bees.com',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Phone: +123 456 7890',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            // Add more information as needed
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
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
              // Handle alert icon tap
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
