import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';

//? Почему стейт только один?
//? Initial хз зачем
//? Loading не хранит закладки, поэтому во время загрузки ничего не видно
//? Failure вроде не нужен, потому что я и так обрабатываю и отображаю ошибки

final class BookmarkState {
  final bool isLoading;
  final bool isSyncing;

  final List<BookmarkModel> bookmarkList;
  final Set<String> folderList;

  BookmarkState(
      {required this.bookmarkList,
      required this.folderList,
      required this.isLoading,
      required this.isSyncing});

  BookmarkState copyWith(
      {bool? isLoading,
      bool? isSyncing,
      List<BookmarkModel>? bookmarkList,
      Set<String>? folderList}) {
    return BookmarkState(
        isLoading: isLoading ?? this.isLoading,
        bookmarkList: bookmarkList ?? this.bookmarkList,
        folderList: folderList ?? this.folderList,
        isSyncing: isSyncing ?? this.isSyncing);
  }
}
