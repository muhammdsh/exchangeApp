import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService instance = ImagePickerService._internal();

  final ImagePicker _picker = ImagePicker();


  factory ImagePickerService() {
    return instance;
  }

  ImagePickerService._internal();

  Future<XFile> getImageFromGallery() {
    return _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: true);
  }

  Future<XFile> getImageFromCamera() {
    return _picker.pickImage(source: ImageSource.camera, requestFullMetadata: true);
  }

  Future<List<XFile>> getMultiImage() {
    return _picker.pickMultiImage();
  }


}