import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/bookmark_list_tile_widget.dart';
import 'package:flutter/material.dart';

/// Список закладок
class BookmarkListWidget extends StatelessWidget {
  final List<BookmarkModel> bookmarkList;

  const BookmarkListWidget({super.key, required this.bookmarkList});

  @override
  Widget build(BuildContext context) {
    //* Рефреш скролом вверх (на мобилке)
    return RefreshIndicator(
      onRefresh: () =>
          context.bookmarkCubit.loadBookmarks(withReload: true, withSync: true),
      child: Padding(
        //* Паддинги по бокам
        padding: const EdgeInsets.only(left: AppPadding.m, right: AppPadding.m),
        child: Center(
          //* Ограничение ширины
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            //* Список из BookmarkListTileWidget с разделителем
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppPadding.s),
              //* Паддинги сверху и снизу (снизу побольше чтобы fab не мешал)
              padding: const EdgeInsets.only(
                  top: AppPadding.m, bottom: AppPadding.xxl),
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarkList[index];
                return BookmarkListTileWidget(bookmark: bookmark);
              },
            ),
          ),
        ),
      ),
    );
  }
}
