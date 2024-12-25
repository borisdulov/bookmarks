import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/bookmark_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkListWidget extends StatelessWidget {
  const BookmarkListWidget({super.key, required this.bookmarkList});

  final List<BookmarkModel> bookmarkList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context
          .read<BookmarkCubit>()
          .loadBookmarks(withReload: true, withSync: true),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 84),
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
