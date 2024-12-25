import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/local_bookmark_repository_interface.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/remote_bookmark_repository_interface.dart';

final class SyncService {
  Future<List<BookmarkModel>?> synchronize(
      {required ILocalBookmarkRepository localRepository,
      required IRemoteBookmarkRepository remoteRepository}) async {
    try {
      final localBookmarks = await localRepository.getAllBookmarks();
      final remoteBookmarks = await remoteRepository.getAllBookmarks();

      final localBookmarkMap = {
        for (var bookmark in localBookmarks) bookmark.url: bookmark
      };
      final remoteBookmarkMap = {
        for (var bookmark in remoteBookmarks) bookmark.url: bookmark
      };

      final mergedBookmarks = <BookmarkModel>[];
      final bookmarksToCreateRemotly = <BookmarkModel>[];
      final bookmarksToDeleteRemotly = <String>[];

      final allUrls = {...localBookmarkMap.keys, ...remoteBookmarkMap.keys};

      for (var url in allUrls) {
        final localBookmark = localBookmarkMap[url];
        final remoteBookmark = remoteBookmarkMap[url];

        if (localBookmark == null) {
          // Bookmark only exists in remote, add to local
          mergedBookmarks.add(remoteBookmark!);
        } else if (remoteBookmark == null) {
          // Bookmark only exists in local, add to remote
          mergedBookmarks.add(localBookmark.copyWith(isSynced: true));
          bookmarksToCreateRemotly.add(localBookmark.copyWith(isSynced: true));
        } else {
          if (localBookmark.updatedAt.isAfter(remoteBookmark.updatedAt)) {
            mergedBookmarks.add(localBookmark);
            bookmarksToDeleteRemotly.add(remoteBookmark.url);
            bookmarksToCreateRemotly.add(localBookmark);
          } else {
            mergedBookmarks.add(remoteBookmark);
          }
        }
      }

      await localRepository.updateBookmarks(mergedBookmarks);
      await remoteRepository.deleteBookmarks(bookmarksToDeleteRemotly);
      await remoteRepository.createBookmarks(bookmarksToCreateRemotly);

      return mergedBookmarks;
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }
}
