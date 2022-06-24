import 'dart:typed_data';

class ImageModel {
  int id;
  String type;
  Uint8List image;

  ImageModel({
    required this.id,
    required this.type,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image'] = image;

    return data;
  }
}
