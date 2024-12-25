import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';

abstract class IRemoteBookmarkRepository {
  Future<List<BookmarkModel>> getAllBookmarks();
  Future<void> createBookmark(BookmarkModel bookmark);
  Future<void> deleteBookmark(String bookmarkUrl);
  Future<void> updateBookmarks(List<BookmarkModel> bookmarks);
  Future<void> createBookmarks(List<BookmarkModel> bookmarks);
  Future<void> deleteBookmarks(List<String> bookmarkUrls);
}
