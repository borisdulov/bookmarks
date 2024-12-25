// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkModelImpl _$$BookmarkModelImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkModelImpl(
      url: json['url'] as String,
      title: json['title'] as String? ?? '',
      note: json['note'] as String? ?? '',
      folder: json['folder'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      ogTitle: json['ogTitle'] as String? ?? '',
      ogDescription: json['ogDescription'] as String? ?? '',
      ogImage: json['ogImage'] as String? ?? '',
      ogSiteName: json['ogSiteName'] as String? ?? '',
      favicon: json['favicon'] as String? ?? '',
      isSynced: json['isSynced'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BookmarkModelImplToJson(_$BookmarkModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'note': instance.note,
      'folder': instance.folder,
      'userId': instance.userId,
      'ogTitle': instance.ogTitle,
      'ogDescription': instance.ogDescription,
      'ogImage': instance.ogImage,
      'ogSiteName': instance.ogSiteName,
      'favicon': instance.favicon,
      'isSynced': instance.isSynced,
      'isDeleted': instance.isDeleted,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
