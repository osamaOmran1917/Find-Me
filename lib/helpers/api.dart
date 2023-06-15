import 'dart:io';

import 'package:http/http.dart' as http;

class API {
  static Future<Map<String, dynamic>> compareImages(File image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/compare_images'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      return {'success': true, 'data': responseBody};
    } else {
      return {'success': false, 'error': 'Failed to compare images'};
    }
  }
}
