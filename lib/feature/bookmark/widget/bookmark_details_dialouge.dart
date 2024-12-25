import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/router/app_router_key.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/create_bookmark_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void showBookmarkDetailsDialog(BookmarkModel bookmark) {
  showDialog(
      context: AppRouterKey.authenticatedKey.currentContext!,
      builder: (BuildContext context) =>
          BookmarkDetailsDialog(bookmark: bookmark));
}

class BookmarkDetailsDialog extends StatelessWidget {
  final BookmarkModel bookmark;

  const BookmarkDetailsDialog({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Card(
          margin: const EdgeInsets.all(AppPadding.m),
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.copy),
                    title: Text('copy'.tr()),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: bookmark.url));
                      context.showSnackBar('Copied!');
                      context.pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text('edit'.tr()),
                    onTap: () {
                      context.pop();
                      showCreateBookmarkWidget(
                          AppRouterKey.authenticatedKey.currentContext!,
                          bookmark: bookmark);
                    },
                  ),
                  ListTile(
                      leading:
                          Icon(Icons.delete, color: context.colorScheme.error),
                      title: Text('delete'.tr(),
                          style: TextStyle(color: context.colorScheme.error)),
                      onTap: () {
                        AppRouterKey
                            .authenticatedKey.currentContext?.bookmarkListCubit
                            .deleteBookmark(bookmark);
                        context.pop();
                      })
                ],
              )),
        ),
      ),
    );
  }
}
