import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/core/service/local_storage_service.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/remote_bookmark_repository_interface.dart';

final class RemoteBookmarkRepository implements IRemoteBookmarkRepository {
  final FirebaseFirestore _firestore;
  final User _user;

  static const String collectionId = 'bookmarks';

  RemoteBookmarkRepository(
      {required FirebaseFirestore firestore,
      required LocalStorageService storage,
      required User user})
      : _firestore = firestore,
        _user = user;

  CollectionReference<Map<String, dynamic>> get _bookmarksCollection =>
      _firestore.collection(collectionId);

  @override
  Future<List<BookmarkModel>> getAllBookmarks() async {
    try {
      final querySnapshot = await _bookmarksCollection
          .where('userId', isEqualTo: _user.uid)
          .get();

      final bookmarkList = querySnapshot.docs.map((document) {
        final documentId = document.id;
        final jsonData = {...document.data(), 'id': documentId};
        return BookmarkModel.fromJson(jsonData);
      }).toList();

      return bookmarkList;
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> updateBookmarks(List<BookmarkModel> bookmarks) async {
    try {
      // Все закладки пользователя
      final userBookmarksQuery =
          _bookmarksCollection.where('userId', isEqualTo: _user.uid);

      // Используем батч для эффективности
      final batch = _firestore.batch();

      // Удаляем все существующие закладки пользователя
      final existingBookmarks = await userBookmarksQuery.get();
      for (var doc in existingBookmarks.docs) {
        batch.delete(doc.reference);
      }

      // Добавляем новые закладки
      for (var bookmark in bookmarks) {
        final bookmarkJson = bookmark.toJson();

        bookmarkJson['userId'] = _user.uid;

        final newBookmarkRef = _bookmarksCollection.doc();
        batch.set(newBookmarkRef, bookmarkJson);
      }

      // Совершаем батч
      await batch.commit();
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<void> createBookmark(BookmarkModel bookmark) async {
    try {
      final bookmarkJson = bookmark.toJson();

      // Найти существующую закладку с таким же URL для текущего пользователя
      final existingBookmarkQuery = await _bookmarksCollection
          .where('userId', isEqualTo: _user.uid)
          .where('url', isEqualTo: bookmark.url)
          .get();

      if (existingBookmarkQuery.docs.isNotEmpty) {
        // Если закладка существует, обновляем ее
        final existingBookmarkDoc = existingBookmarkQuery.docs.first;
        await existingBookmarkDoc.reference
            .update({...bookmarkJson, "userId": _user.uid});
      } else {
        // Если закладки нет, создаем новую
        await _bookmarksCollection.add({...bookmarkJson, "userId": _user.uid});
      }
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<void> deleteBookmark(String url) async {
    try {
      final querySnapshot = await _bookmarksCollection
          .where('userId', isEqualTo: _user.uid)
          .where('url', isEqualTo: url)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
      }
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<void> deleteBookmarks(List<String> urls) async {
    if (urls.isEmpty) return;
    try {
      final batch = _firestore.batch();

      final querySnapshot = await _bookmarksCollection
          .where('userId', isEqualTo: _user.uid)
          .where('url', whereIn: urls)
          .get();

      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  @override
  Future<void> createBookmarks(List<BookmarkModel> bookmarks) async {
    if (bookmarks.isEmpty) return;
    try {
      final batch = _firestore.batch();
      final bookmarkIds = <String>[];

      for (final bookmark in bookmarks) {
        final jsonData = bookmark.toJson();
        final docRef = _bookmarksCollection.doc();
        batch.set(docRef, {...jsonData, "userId": _user.uid});
        bookmarkIds.add(docRef.id);
      }

      await batch.commit();
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }
}
