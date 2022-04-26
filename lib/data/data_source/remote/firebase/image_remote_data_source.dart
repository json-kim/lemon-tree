import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class ImageRemoteDataSource {
  final storage = FirebaseStorage.instance;
  final uuid = Uuid();

  Future<String> imageUploadRequest(File image) async {
    String fileName = 'image/${uuid.v1()}${path.basename(image.path)}';

    final ref = storage.ref(fileName);

    await ref.putFile(image);

    final url = await ref.getDownloadURL();
    print(url);

    return url;
  }
}
