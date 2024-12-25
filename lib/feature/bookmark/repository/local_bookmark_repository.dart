import 'dart:convert';
import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/core/service/local_storage_service.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/local_bookmark_repository_interface.dart';

class LocalBookmarkRepository implements ILocalBookmarkRepository {
  final LocalStorageService _storage;
  static const String _localBookmarksKey = 'bookmarks';

  LocalBookmarkRepository({required LocalStorageService storage})
      : _storage = storage;

  @override
  Future<List<BookmarkModel>> getAllBookmarks() async {
    try {
      final jsonString = await _storage.getString(_localBookmarksKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => BookmarkModel.fromJson(json)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> updateBookmarks(List<BookmarkModel> bookmarks) async {
    try {
      final jsonList = bookmarks.map((bookmark) => bookmark.toJson()).toList();
      await _storage.saveString(_localBookmarksKey, json.encode(jsonList));
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<List<BookmarkModel>?> createBookmark(BookmarkModel bookmark) async {
    try {
      final bookmarks = await getAllBookmarks();

      final filteredBookmarks =
          bookmarks.where((b) => b.url != bookmark.url).toList();

      filteredBookmarks.add(bookmark);
      await updateBookmarks(filteredBookmarks);
      return filteredBookmarks;
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<BookmarkModel>?> deleteBookmark(BookmarkModel bookmark) async {
    try {
      //TODO надо будет потом над этим подумать
      // if (bookmark.isSynced) {
      //   //? Если закладка есть в облаке, ее нельзя просто так убрать
      //   //? Это должно произойти при следующей синхронизации
      //   return await createBookmark(bookmark.copyWith(isDeleted: true));
      // } else {
      final bookmarks = await getAllBookmarks();
      bookmarks.removeWhere((b) => b.url == bookmark.url);

      await updateBookmarks(bookmarks);
      return bookmarks;
      // }
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }

  // @override
  // Future<BookmarkModel?> getBookmark(String bookmarkUrl) async {
  //   try {
  //     final localBookmarks = await getAllBookmarks();
  //     final foundBookmarkIndex =
  //         localBookmarks.indexWhere((bookmark) => bookmark.url == bookmarkUrl);

  //     if (foundBookmarkIndex != -1) {
  //       return localBookmarks[foundBookmarkIndex];
  //     }

  //     return null;
  //   } catch (e) {
  //     AppExceptionHandler.handleException(
  //         AppRouterKey.rootKey.currentContext!, e);
  //     return null;
  //   }
  // }

  // @override
  // Future<void> updateBookmark(BookmarkModel bookmark) async {
  //   try {
  //     final localBookmarks = await getAllBookmarks();
  //     final index = localBookmarks.indexWhere((b) => b.url == bookmark.url);

  //     if (index == -1) {
  //       throw BookmarkNotFoundException(
  //           'Bookmark update failed because bookmark with this url not found.');
  //     }

  //     localBookmarks[index] = bookmark;
  //     await updateBookmarks(localBookmarks);
  //   } catch (e) {
  //     AppExceptionHandler.handleException(
  //         AppRouterKey.rootKey.currentContext!, e);
  //   }
  // }

  // @override
  // Future<void> createBookmarks(List<BookmarkModel> bookmarks) async {
  //   try {
  //     final localBookmarks = await getAllBookmarks();

  //     //TODO realisation

  //     await updateBookmarks(localBookmarks);
  //   } catch (e) {
  //     AppExceptionHandler.handleException(
  //         AppRouterKey.rootKey.currentContext!, e);
  //   }
  // }

  // @override
  // Future<void> deleteBookmarks(List<String> bookmarkUrls) async {
  //   try {
  //     final localBookmarks = await getAllBookmarks();

  //     localBookmarks
  //         .removeWhere((bookmark) => bookmarkUrls.contains(bookmark.url));

  //     await updateBookmarks(localBookmarks);
  //   } catch (e) {
  //     AppExceptionHandler.handleException(
  //         AppRouterKey.rootKey.currentContext!, e);
  //   }
  // }
}
