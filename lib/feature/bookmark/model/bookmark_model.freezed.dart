// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookmarkModel _$BookmarkModelFromJson(Map<String, dynamic> json) {
  return _BookmarkModel.fromJson(json);
}

/// @nodoc
mixin _$BookmarkModel {
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get folder => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError; // Данные для превью
  String get ogTitle => throw _privateConstructorUsedError;
  String get ogDescription => throw _privateConstructorUsedError;
  String get ogImage => throw _privateConstructorUsedError;
  String get ogSiteName => throw _privateConstructorUsedError;
  String get favicon =>
      throw _privateConstructorUsedError; // Данные для синхронизации
  bool get isSynced => throw _privateConstructorUsedError; // Есть ли в облаке
  bool get isDeleted =>
      throw _privateConstructorUsedError; // Метка для удаления при синхронизации
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BookmarkModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkModelCopyWith<BookmarkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkModelCopyWith<$Res> {
  factory $BookmarkModelCopyWith(
          BookmarkModel value, $Res Function(BookmarkModel) then) =
      _$BookmarkModelCopyWithImpl<$Res, BookmarkModel>;
  @useResult
  $Res call(
      {String url,
      String title,
      String note,
      String folder,
      String userId,
      String ogTitle,
      String ogDescription,
      String ogImage,
      String ogSiteName,
      String favicon,
      bool isSynced,
      bool isDeleted,
      DateTime updatedAt});
}

/// @nodoc
class _$BookmarkModelCopyWithImpl<$Res, $Val extends BookmarkModel>
    implements $BookmarkModelCopyWith<$Res> {
  _$BookmarkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? note = null,
    Object? folder = null,
    Object? userId = null,
    Object? ogTitle = null,
    Object? ogDescription = null,
    Object? ogImage = null,
    Object? ogSiteName = null,
    Object? favicon = null,
    Object? isSynced = null,
    Object? isDeleted = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      ogTitle: null == ogTitle
          ? _value.ogTitle
          : ogTitle // ignore: cast_nullable_to_non_nullable
              as String,
      ogDescription: null == ogDescription
          ? _value.ogDescription
          : ogDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ogImage: null == ogImage
          ? _value.ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as String,
      ogSiteName: null == ogSiteName
          ? _value.ogSiteName
          : ogSiteName // ignore: cast_nullable_to_non_nullable
              as String,
      favicon: null == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkModelImplCopyWith<$Res>
    implements $BookmarkModelCopyWith<$Res> {
  factory _$$BookmarkModelImplCopyWith(
          _$BookmarkModelImpl value, $Res Function(_$BookmarkModelImpl) then) =
      __$$BookmarkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String title,
      String note,
      String folder,
      String userId,
      String ogTitle,
      String ogDescription,
      String ogImage,
      String ogSiteName,
      String favicon,
      bool isSynced,
      bool isDeleted,
      DateTime updatedAt});
}

/// @nodoc
class __$$BookmarkModelImplCopyWithImpl<$Res>
    extends _$BookmarkModelCopyWithImpl<$Res, _$BookmarkModelImpl>
    implements _$$BookmarkModelImplCopyWith<$Res> {
  __$$BookmarkModelImplCopyWithImpl(
      _$BookmarkModelImpl _value, $Res Function(_$BookmarkModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookmarkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? note = null,
    Object? folder = null,
    Object? userId = null,
    Object? ogTitle = null,
    Object? ogDescription = null,
    Object? ogImage = null,
    Object? ogSiteName = null,
    Object? favicon = null,
    Object? isSynced = null,
    Object? isDeleted = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookmarkModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      folder: null == folder
          ? _value.folder
          : folder // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      ogTitle: null == ogTitle
          ? _value.ogTitle
          : ogTitle // ignore: cast_nullable_to_non_nullable
              as String,
      ogDescription: null == ogDescription
          ? _value.ogDescription
          : ogDescription // ignore: cast_nullable_to_non_nullable
              as String,
      ogImage: null == ogImage
          ? _value.ogImage
          : ogImage // ignore: cast_nullable_to_non_nullable
              as String,
      ogSiteName: null == ogSiteName
          ? _value.ogSiteName
          : ogSiteName // ignore: cast_nullable_to_non_nullable
              as String,
      favicon: null == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkModelImpl implements _BookmarkModel {
  _$BookmarkModelImpl(
      {required this.url,
      this.title = '',
      this.note = '',
      this.folder = '',
      this.userId = '',
      this.ogTitle = '',
      this.ogDescription = '',
      this.ogImage = '',
      this.ogSiteName = '',
      this.favicon = '',
      this.isSynced = false,
      this.isDeleted = false,
      required this.updatedAt});

  factory _$BookmarkModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkModelImplFromJson(json);

  @override
  final String url;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String folder;
  @override
  @JsonKey()
  final String userId;
// Данные для превью
  @override
  @JsonKey()
  final String ogTitle;
  @override
  @JsonKey()
  final String ogDescription;
  @override
  @JsonKey()
  final String ogImage;
  @override
  @JsonKey()
  final String ogSiteName;
  @override
  @JsonKey()
  final String favicon;
// Данные для синхронизации
  @override
  @JsonKey()
  final bool isSynced;
// Есть ли в облаке
  @override
  @JsonKey()
  final bool isDeleted;
// Метка для удаления при синхронизации
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BookmarkModel(url: $url, title: $title, note: $note, folder: $folder, userId: $userId, ogTitle: $ogTitle, ogDescription: $ogDescription, ogImage: $ogImage, ogSiteName: $ogSiteName, favicon: $favicon, isSynced: $isSynced, isDeleted: $isDeleted, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.folder, folder) || other.folder == folder) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.ogTitle, ogTitle) || other.ogTitle == ogTitle) &&
            (identical(other.ogDescription, ogDescription) ||
                other.ogDescription == ogDescription) &&
            (identical(other.ogImage, ogImage) || other.ogImage == ogImage) &&
            (identical(other.ogSiteName, ogSiteName) ||
                other.ogSiteName == ogSiteName) &&
            (identical(other.favicon, favicon) || other.favicon == favicon) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      url,
      title,
      note,
      folder,
      userId,
      ogTitle,
      ogDescription,
      ogImage,
      ogSiteName,
      favicon,
      isSynced,
      isDeleted,
      updatedAt);

  /// Create a copy of BookmarkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkModelImplCopyWith<_$BookmarkModelImpl> get copyWith =>
      __$$BookmarkModelImplCopyWithImpl<_$BookmarkModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkModelImplToJson(
      this,
    );
  }
}

abstract class _BookmarkModel implements BookmarkModel {
  factory _BookmarkModel(
      {required final String url,
      final String title,
      final String note,
      final String folder,
      final String userId,
      final String ogTitle,
      final String ogDescription,
      final String ogImage,
      final String ogSiteName,
      final String favicon,
      final bool isSynced,
      final bool isDeleted,
      required final DateTime updatedAt}) = _$BookmarkModelImpl;

  factory _BookmarkModel.fromJson(Map<String, dynamic> json) =
      _$BookmarkModelImpl.fromJson;

  @override
  String get url;
  @override
  String get title;
  @override
  String get note;
  @override
  String get folder;
  @override
  String get userId; // Данные для превью
  @override
  String get ogTitle;
  @override
  String get ogDescription;
  @override
  String get ogImage;
  @override
  String get ogSiteName;
  @override
  String get favicon; // Данные для синхронизации
  @override
  bool get isSynced; // Есть ли в облаке
  @override
  bool get isDeleted; // Метка для удаления при синхронизации
  @override
  DateTime get updatedAt;

  /// Create a copy of BookmarkModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkModelImplCopyWith<_$BookmarkModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
