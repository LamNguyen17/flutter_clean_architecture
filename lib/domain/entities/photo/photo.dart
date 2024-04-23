import 'package:equatable/equatable.dart';

class Photos extends Equatable {
  int total;
  int totalHits;
  List<Hits>? hits;

  Photos({
    required this.total,
    required this.totalHits,
    this.hits,
  });

  @override
  List<Object?> get props => [
        total,
        totalHits,
        hits,
      ];
}

class Hits extends Equatable {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;

  Hits({
    this.id,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL,
    this.previewWidth,
    this.previewHeight,
    this.webformatURL,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageURL,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageURL,
  });

  @override
  List<Object?> get props => [
        id,
        pageURL,
        type,
        tags,
        previewURL,
        previewWidth,
        previewHeight,
        webformatURL,
        webformatWidth,
        webformatHeight,
        largeImageURL,
        imageWidth,
        imageHeight,
        imageSize,
        views,
        downloads,
        collections,
        likes,
        comments,
        userId,
        user,
        userImageURL,
      ];
}
