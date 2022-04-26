import 'dart:io';

import 'package:lemon_tree/data/data_source/remote/firebase/image_remote_data_source.dart';
import 'package:lemon_tree/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource _dataSource;

  ImageRepositoryImpl(this._dataSource);

  @override
  Future<String> uploadImage(File file) async {
    return await _dataSource.imageUploadRequest(file);
  }
}
