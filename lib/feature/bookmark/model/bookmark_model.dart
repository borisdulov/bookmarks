import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_model.freezed.dart';
part 'bookmark_model.g.dart';

@freezed
class BookmarkModel with _$BookmarkModel {
  factory BookmarkModel({
    required String url,
    @Default('') String title,
    @Default('') String note,
    @Default('') String folder,
    @Default('') String userId,
    // Данные для превью
    @Default('') String ogTitle,
    @Default('') String ogDescription,
    @Default('') String ogImage,
    @Default('') String ogSiteName,
    @Default('') String favicon,
    // Данные для синхронизации
    @Default(false) bool isSynced, // Есть ли в облаке
    @Default(false) bool isDeleted, // Метка для удаления при синхронизации
    required DateTime updatedAt,
    //? Если копия закладки находится в облаке, мы не удаляем ее локально, а помечаем удаленной (isDeleted)
    //? Это сделано для того, чтобы при синхронизации понять, что эту заметку надо удалить из облака
  }) = _BookmarkModel;

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);
}
