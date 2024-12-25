import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';

abstract class ILocalBookmarkRepository {
  Future<List<BookmarkModel>> getAllBookmarks();
  Future<List<BookmarkModel>?> createBookmark(BookmarkModel bookmark);
  Future<List<BookmarkModel>?> deleteBookmark(BookmarkModel bookmark);
  Future<void> updateBookmarks(List<BookmarkModel> bookmarks);
}
