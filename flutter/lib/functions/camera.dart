import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
// Pick an image
pickImageFromGallery() {
  return _picker.pickImage(source: ImageSource.gallery);
}

Future<XFile?> pickImageFromCamera() {
  return _picker.pickImage(source: ImageSource.camera);
}

Future<List<XFile>> pickMultipleFromGallery() {
  return _picker.pickMultiImage();
}
