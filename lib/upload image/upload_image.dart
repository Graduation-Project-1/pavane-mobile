import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {

  static Future<List<XFile>?> pickImagesFromGallery(BuildContext context) async {
    List<XFile>? resultList = [];
    final ImagePicker _picker = ImagePicker();
    try {
      resultList = await _picker.pickMultiImage(imageQuality: 50);
      return resultList;
    } on Exception catch (e) {
      print('this is pickImages error:$e');
      return resultList;
    }
  }

  static Future<String> uploadImage(XFile image, String path) async {
    bool requestStatus;
    String imageUrl = '';
    try {
      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        'directory': path,
      });

      var response = await Dio().post(
        "https://egyservices.net/api/v1/upload-image",
        data: formData,
      );
      requestStatus = response.data['status'];
      if (requestStatus) {
        print(response.data);
        imageUrl = response.data['data'];

        return imageUrl;
      } else {
        print(response.data);
      }
    } catch (e, trace) {
      print(trace);
      print('this is upload image error:$e');
    }
    //   }
    return imageUrl;
  }
}
