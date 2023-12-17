import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PostDraft {
  List<XFile?> selectedImages;
  File? video;
  String postContent;
  String status;
  String autoAccept;

  PostDraft({
    required this.selectedImages,
    this.video,
    required this.postContent,
    required this.status,
    required this.autoAccept,
  });

  factory PostDraft.fromJson(Map<String, dynamic> json) {
    return PostDraft(
      selectedImages: (json['selectedImages'] as List<dynamic>)
          .map((imagePath) => XFile(imagePath as String))
          .toList(),
      video: json['video'] != null ? File(json['video'] as String) : null,
      postContent: json['postContent'] as String,
      status: json['status'] as String,
      autoAccept: json['autoAccept'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedImages': selectedImages.map((image) => image?.path).toList(),
      'video': video?.path,
      'postContent': postContent,
      'status': status,
      'autoAccept': autoAccept,
    };
  }
}
