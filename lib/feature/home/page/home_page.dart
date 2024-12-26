import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_builder.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/bookmark_list_widget.dart';
import 'package:firebase_auth_ex/feature/home/widget/drawer_widget.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/create_bookmark_widget.dart';
import 'package:flutter/material.dart';

/// Главный экран с поиском, выбором папки и списком закладок
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const path = '/';

  @override
  HomePageState createState() => HomePageState();
}

//? Хз что делает этот миксин, но помоему с ним табы перелистываются лучше
class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  List<BookmarkModel> _filteredBookmarks = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    final bookmarks = context.bookmarkCubit.state.bookmarkList;
    final searchQuery = _searchController.text.toLowerCase().trim();

    setState(() {
      if (searchQuery.isEmpty) {
        _isSearching = false;
      } else {
        _isSearching = true;

        //* Поиск по title и url (без учета регистра)
        _filteredBookmarks = bookmarks.where((bookmark) {
          final titleMatch = bookmark.title.toLowerCase().contains(searchQuery);
          final urlMatch = bookmark.url.toLowerCase().contains(searchQuery);

          return titleMatch || urlMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BookmarkBuilder(builder: (context, state) {
      final bookmarkList =
          _isSearching ? _filteredBookmarks : state.bookmarkList;

      return DefaultTabController(
        //? +1 потому что тут нет папки All
        length: state.folderList.length + 1,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            //? Убираем кнопку шторки, чтобы сделать свою
            automaticallyImplyLeading: false,
            toolbarHeight: AppPadding.xxl,
            title: Column(
              children: [
                const SizedBox(height: AppPadding.m),
                Builder(builder: (context) {
                  //* Поиск по закладкам
                  return SearchBar(
                    elevation: const WidgetStatePropertyAll(0),
                    controller: _searchController,
                    hintText: 'searchBookmarks'.tr(),

                    //* Кнопка шторки
                    leading: IconButton(
                      hoverColor: context.colorScheme.surface,
                      icon: Icon(
                        Icons.menu,
                        color: context.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),

                    //* Кнопка очистки поиска
                    trailing: [
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: context.colorScheme.onSurface,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                    ],
                  );
                }),
              ],
            ),
            //* Табы
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(AppPadding.xl),
              child: TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                tabs: [
                  //* Таб All
                  Tab(text: 'all'.tr()),
                  //* Остальные табы
                  ...state.folderList.map((folder) => Tab(text: folder)),
                ],
              ),
            ),
          ),

          //* Стэк чтобы LinearProgressIndicator норм отображался
          body: Stack(
            children: [
              //* Списки закладок
              TabBarView(children: [
                //* Список всех закладок
                BookmarkListWidget(bookmarkList: bookmarkList),
                //* Остальные папки
                ...state.folderList.map((folder) {
                  return BookmarkListWidget(
                    bookmarkList: bookmarkList
                        .where((bookmark) => bookmark.folder == folder)
                        .toList(),
                  );
                }),
              ]),

              //* Отображение загрузки
              if (state.isLoading || state.isSyncing)
                const LinearProgressIndicator(),
            ],
          ),

          //* Кнопка создания закладки
          floatingActionButton: FilledButton(
            onPressed: () {
              showCreateBookmarkWidget(context);
            },
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: const Size(64, 64),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.add_link, size: 32),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
