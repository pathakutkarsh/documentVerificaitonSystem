import 'package:document_verification_system/constants/variables.dart';
import 'package:http/http.dart' as http;

Future<String> uploadFilesHttpPostRequest() async {
  String serverURL = getServerURL();
  print("========================================");
  print(serverURL);
  var request = http.MultipartRequest('POST', Uri.parse(serverURL));
  request.fields['image_url'] = "File Namegoes here";
  // for (int i = 0; i < uploadjson.image.length; i++) {
  //   request.files.add(await http.MultipartFile(
  //       'image_url',
  //       uploadjson.image[i].readAsBytes().asStream(),
  //       uploadjson.image[i].lengthSync(),
  //       filename: basename(uploadjson.image[i].path)));
  // }
  request.headers.addAll({'cache-control': 'private, max-age=120'});
  print(request.fields.toString());
  var response = await request.send().then((value) => print("Request sent"));
  print("=================");
  print("request sent");
  // var decoded = json.decode(respStr);
  // if (response.statusCode == 200) {
  //   print("====================================");
  //   print(await response.stream.bytesToString());
  // }
  return "afjfads";
}