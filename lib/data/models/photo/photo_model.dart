import 'package:flutter_clean_architecture/domain/entities/photo/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class HitsResponse {
  final int id;
  final String? pageURL;
  final String? type;
  final String? tags;
  final String? previewURL;
  final int? previewWidth;
  final int? previewHeight;
  final String? webformatURL;
  final int? webformatWidth;
  final int? webformatHeight;
  final String? largeImageURL;
  final int? imageWidth;
  final int? imageHeight;
  final int? imageSize;
  final int? views;
  final int? downloads;
  final int? collections;
  final int? likes;
  final int? comments;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? user;
  final String? userImageURL;

  HitsResponse(
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
  );

  factory HitsResponse.fromJson(Map<String, dynamic> json) =>
      _$HitsResponseFromJson(json);

  HitsResponse toJson() => _$HitsResponseFromJson(this as Map<String, dynamic>);

  Hits toEntity() {
    return Hits(
      id: id,
      pageURL: pageURL,
      type: type,
      tags: tags,
      previewURL: previewURL,
      previewWidth: previewWidth,
      previewHeight: previewHeight,
      webformatURL: webformatURL,
      webformatWidth: webformatWidth,
      webformatHeight: webformatHeight,
      largeImageURL: largeImageURL,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      imageSize: imageSize,
      views: views,
      downloads: downloads,
      collections: collections,
      likes: likes,
      comments: comments,
      userId: userId,
      user: user,
      userImageURL: userImageURL,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PhotosResponse {
  final int total;
  final int totalHits;
  final List<HitsResponse>? hits;

  PhotosResponse(
    this.total,
    this.totalHits,
    this.hits,
  );

  factory PhotosResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosResponseToJson(this);

  Photos toEntity() {
    return Photos(
      total: total,
      totalHits: totalHits,
      hits: hits?.map((x) => x.toEntity()).toList(),
    );
  }
}
