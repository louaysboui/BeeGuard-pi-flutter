import 'package:firebase_storage/firebase_storage.dart';

class FireStoreDataBase {
  Future<List<String>> getImages() async {
    List<String> imageUrls = [];

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('gs://rpi-image-b98b8.appspot.com');
      print(ref);
      // List all items under this directory
      ListResult result = await ref.listAll();
      // Iterate over items and get download URLs
      for (Reference ref in result.items) {
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
    } catch (e) {
      print("Error fetching images: $e");
    }
    return imageUrls;
  }
}
