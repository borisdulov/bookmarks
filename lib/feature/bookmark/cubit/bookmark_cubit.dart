import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/feature/bookmark/exception/bookmark_exception.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/local_bookmark_repository_interface.dart';
import 'package:firebase_auth_ex/feature/bookmark/service/preview_service.dart';
import 'package:firebase_auth_ex/feature/bookmark/service/sync_service.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_state.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/remote_bookmark_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  //? Я пытался привести их под один интерфейс, но это только мешало и пользы не было
  //TODO надо бы все таки привести их к одному, а то не красиво
  final ILocalBookmarkRepository _localRepository;
  final IRemoteBookmarkRepository? _remoteRepository;

  final SyncService _syncService;
  final PreviewService _previewService;

  BookmarkCubit(
      {required ILocalBookmarkRepository localRepository,
      IRemoteBookmarkRepository? remoteRepository,
      required SyncService syncService,
      required PreviewService previewService})
      //
      : _localRepository = localRepository,
        _remoteRepository = remoteRepository,
        _syncService = syncService,
        _previewService = previewService,
        //
        super(BookmarkState(
            isLoading: false,
            bookmarkList: [],
            folderList: {},
            isSyncing: false)) {
    loadBookmarks(withReload: true, withSync: true);
  }

  /// Подгрузить закладки в стейт
  Future<void> loadBookmarks(
      {bool withReload = false, bool withSync = false}) async {
    try {
      //* Хз что может произойти если подгрузить еще раз во время загрузки
      //* На всяки случай нельзя
      if (state.isLoading) throw AlreadyLoadingException;

      emit(state.copyWith(isLoading: withReload, isSyncing: withSync));

      List<BookmarkModel>? bookmarkList;

      if (withSync && _remoteRepository != null) {
        bookmarkList = await _syncService.synchronize(
            localRepository: _localRepository,
            remoteRepository: _remoteRepository);
      }

      bookmarkList ??= await _localRepository.getAllBookmarks();

      final folderList = bookmarkList
          .map((bookmark) => bookmark.folder)
          .where((folder) => folder.isNotEmpty)
          .toSet();

      emit(state.copyWith(
          bookmarkList: bookmarkList,
          folderList: folderList,
          isLoading: false,
          isSyncing: false));
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      if (e is! AlreadyLoadingException) {
        emit(state.copyWith(isLoading: false, isSyncing: false));
      }
    }
  }

  /// Создание закладки в стейте, локальном и удаленом репозитории
  Future<void> createBookmark(BookmarkModel bookmark) async {
    try {
      //* Хз что может произойти, на всяки случай нельзя
      if (state.isLoading) throw AlreadyLoadingException;

      emit(state.copyWith(isLoading: true));

      final updatedBookmarkList =
          await _localRepository.createBookmark(bookmark);

      final updatedFolderList = state.folderList;
      if (bookmark.folder.isNotEmpty) {
        updatedFolderList.add(bookmark.folder);
      }

      emit(state.copyWith(
          bookmarkList: updatedBookmarkList, folderList: updatedFolderList));

      final bookmarkWithPreview =
          await _previewService.addPreviewData(bookmark);

      if (bookmarkWithPreview != null) {
        final updatedBookmarkList =
            await _localRepository.createBookmark(bookmarkWithPreview);

        emit(state.copyWith(
            bookmarkList: updatedBookmarkList,
            isLoading: false,
            isSyncing: true));

        await _remoteRepository?.createBookmark(bookmarkWithPreview);
      } else {
        emit(state.copyWith(isLoading: false, isSyncing: true));

        await _remoteRepository?.createBookmark(bookmark);
      }
      emit(state.copyWith(isSyncing: false));
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      if (e is! AlreadyLoadingException) {
        emit(state.copyWith(isLoading: false, isSyncing: false));
      }
    }
  }

  /// Удаление закладки в стейте, локальном и удаленом репозитории
  Future<void> deleteBookmark(BookmarkModel bookmark) async {
    try {
      //* Хз что может произойти, на всяки случай нельзя
      if (state.isLoading) throw AlreadyLoadingException;

      emit(state.copyWith(isLoading: true));

      final updatedBookmarkList = state.bookmarkList
        ..removeWhere((b) => b.url == bookmark.url);
      final updatedFolderList = state.folderList..remove(bookmark.folder);

      emit(state.copyWith(
          bookmarkList: updatedBookmarkList, folderList: updatedFolderList));

      await _localRepository.deleteBookmark(bookmark);

      emit(state.copyWith(isLoading: false, isSyncing: true));

      await _remoteRepository?.deleteBookmark(bookmark.url);

      emit(state.copyWith(isSyncing: false));
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      if (e is! AlreadyLoadingException) {
        emit(state.copyWith(isLoading: false, isSyncing: false));
      }
    }
  }

  BookmarkModel? getBookmarkByUrl(String url) {
    final bookmarkList = state.bookmarkList;

    final foundBookmarkId = bookmarkList.indexWhere(
      (bookmark) => bookmark.url == url,
    );

    if (foundBookmarkId != -1) {
      return bookmarkList[foundBookmarkId];
    }
    return null;
  }
}
