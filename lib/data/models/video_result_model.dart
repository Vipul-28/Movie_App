import 'package:movie_app/data/models/video_model.dart';

class VideoResultModel {
  int? id;
  List<VideoModel>? results;

  VideoResultModel({this.id, this.results});

  VideoResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = <VideoModel>[];
      json['results'].forEach((v) {
        results!.add(new VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

