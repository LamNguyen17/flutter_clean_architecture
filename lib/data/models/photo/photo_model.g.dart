// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitsResponse _$HitsResponseFromJson(Map<String, dynamic> json) => HitsResponse(
      json['id'] as int,
      json['pageURL'] as String?,
      json['type'] as String?,
      json['tags'] as String?,
      json['previewURL'] as String?,
      json['previewWidth'] as int?,
      json['previewHeight'] as int?,
      json['webformatURL'] as String?,
      json['webformatWidth'] as int?,
      json['webformatHeight'] as int?,
      json['largeImageURL'] as String?,
      json['imageWidth'] as int?,
      json['imageHeight'] as int?,
      json['imageSize'] as int?,
      json['views'] as int?,
      json['downloads'] as int?,
      json['collections'] as int?,
      json['likes'] as int?,
      json['comments'] as int?,
      json['user_id'] as int?,
      json['user'] as String?,
      json['userImageURL'] as String?,
    );

Map<String, dynamic> _$HitsResponseToJson(HitsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageURL': instance.pageURL,
      'type': instance.type,
      'tags': instance.tags,
      'previewURL': instance.previewURL,
      'previewWidth': instance.previewWidth,
      'previewHeight': instance.previewHeight,
      'webformatURL': instance.webformatURL,
      'webformatWidth': instance.webformatWidth,
      'webformatHeight': instance.webformatHeight,
      'largeImageURL': instance.largeImageURL,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageSize': instance.imageSize,
      'views': instance.views,
      'downloads': instance.downloads,
      'collections': instance.collections,
      'likes': instance.likes,
      'comments': instance.comments,
      'user_id': instance.userId,
      'user': instance.user,
      'userImageURL': instance.userImageURL,
    };

PhotosResponse _$PhotosResponseFromJson(Map<String, dynamic> json) =>
    PhotosResponse(
      json['total'] as int,
      json['totalHits'] as int,
      (json['hits'] as List<dynamic>?)
          ?.map((e) => HitsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotosResponseToJson(PhotosResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.hits?.map((e) => e.toJson()).toList(),
    };
