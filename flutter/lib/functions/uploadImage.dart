import 'package:document_verification_system/constants/variables.dart';
import 'package:http/http.dart' as http;

Future<String> uploadFilesHttpPostRequest() async {
  String serverURL = getServerURL();
  print("========================================");
  print(serverURL);
  var request = http.MultipartRequest(
      'POST', Uri.parse(serverURL + "/api/image/postImage"));
  request.fields['imageUrl'] = "File URL";
  request.fields['imageId'] = "1";
  request.fields['imageName'] = "FileName";
  request.fields['userId'] = "1";
  request.fields['requestedById'] = "7";
  // for (int i = 0; i < uploadjson.image.length; i++) {
  //   request.files.add(await http.MultipartFile(
  //       'image_url',
  //       uploadjson.image[i].readAsBytes().asStream(),
  //       uploadjson.image[i].lengthSync(),
  //       filename: basename(uploadjson.image[i].path)));
  // }
  // request.headers.addAll({'cache-control': 'private, max-age=120'});
  print(request.fields.toString());
  var response = await request.send();
  print("=================");
  print("request sent");
  // var decoded = json.decode(respStr);
  if (response.statusCode == 200) {
    print("=================response 200===================");
    print(await response.stream.bytesToString());
  }
  return "afjfads";
}

Future<String> getUploadedFile() async {
  String serverURL = getServerURL();

  var response = await http.get(Uri.parse(serverURL + "/api/image/getImage"));
  print("=================");
  print("request sent");
  return "afjfads";
}

Future<String> getUploadedFileById({String id = "1"}) async {
  String serverURL = getServerURL();

  var response =
      await http.get(Uri.parse(serverURL + "/api/image/getImagebyid/$id"));
  print("=================");
  print("request sent");
  // This will give list of documents
  return "afjfads";
}

//get image by id