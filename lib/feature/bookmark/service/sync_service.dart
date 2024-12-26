import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/local_bookmark_repository_interface.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/remote_bookmark_repository_interface.dart';

/// Сервис для синхронизации закладок в локальном и удаленном репоизториях
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
          //* Если закладка только в удаленном репозитории
          mergedBookmarks.add(remoteBookmark!);
        } else if (remoteBookmark == null) {
          //* Если закладка только в локальном репозитории
          mergedBookmarks.add(localBookmark.copyWith(isSynced: true));
          bookmarksToCreateRemotly.add(localBookmark.copyWith(isSynced: true));
        } else {
          //* Если закладка в обоих репозиториях
          //? Какая то из них может быть новее, надо проверить
          if (localBookmark.updatedAt == remoteBookmark.updatedAt) {
            //* Дата создания одинаковая
            mergedBookmarks.add(localBookmark);
          } else if (localBookmark.updatedAt
              .isAfter(remoteBookmark.updatedAt)) {
            //* Локальная новее
            mergedBookmarks.add(localBookmark);
            bookmarksToDeleteRemotly.add(remoteBookmark.url);
            bookmarksToCreateRemotly.add(localBookmark);
          } else {
            //* Удаленная новее
            mergedBookmarks.add(remoteBookmark);
          }
        }
      }

      //TODO локальному репозиторию тоже надо методы createBookmarks и deleteBookmarks
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
