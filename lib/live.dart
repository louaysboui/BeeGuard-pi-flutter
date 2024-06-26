import 'package:flutter/material.dart';
import 'package:flutter_formation/Firebase/database_manager.dart';

class LiveCam extends StatelessWidget {
  const LiveCam({super.key, Key? key});

  @override
  Widget build(BuildContext context) {
    //Initialize Firebase before the build method is executed

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
          'Live Camera',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FireStoreDataBase()
            .getImages(), // Assuming this method fetches image URLs
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Image.network(
                snapshot.data![index],
                fit: BoxFit.cover, // Adjust to your needs
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
