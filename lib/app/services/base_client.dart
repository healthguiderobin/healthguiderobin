import 'dart:convert';
// import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../data/strings.dart';

class BaseClient {
  static Future<String> uploadImage({
    required String imgPath,
  }) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String folder = '${AppStrings.kAppName}/Profile Pictures';

    // log('timestamp: $timestamp');

    Map<String, dynamic> params = {
      'timestamp': timestamp.toString(),
      'upload_preset': AppStrings.kUploadPreset,
      'folder': folder,
      'eager': 'c_limit,f_auto,q_auto,w_1000,h_1000', // Fix format
    };

    // 3. Generate the signature
    String signature = generateSignature(
      params: params,
    );

    // Prepare FormData
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imgPath,
        filename: 'upload.jpg',
      ),
      ...params,
      'api_key': AppStrings.kApiKey,
      'signature': signature,
      'folder': folder,
    });

    final url =
        'https://api.cloudinary.com/v1_1/${AppStrings.kCloudName}/image/upload';

    try {
      final response = await Dio().post(url, data: formData);
      if (response.statusCode == 200) {
        final responseData = response.data;
        final imageUrl = responseData['url'];
        // print('Uploaded Image URL: $imageUrl');
        return imageUrl;
      } else {
        // print('Failed to upload image. Status Code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      // print('Error uploading image: $e');
      return '';
    }
  }

  static String generateSignature({
    required Map<String, dynamic> params,
  }) {
    String apiSecret = AppStrings.kApiSecret;
    var sortedKeys = params.keys.toList()..sort();
    var paramString = sortedKeys.map((key) => '$key=${params[key]}').join('&');

    var bytes = utf8.encode('$paramString$apiSecret');
    var digest = sha1.convert(bytes);

    return digest.toString();
  }
}
