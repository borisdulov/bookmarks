import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/utils/network_utils.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/bookmark_details_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';

class BookmarkListTileWidget extends StatelessWidget {
  const BookmarkListTileWidget({
    super.key,
    required this.bookmark,
  });

  final BookmarkModel bookmark;

  @override
  Widget build(BuildContext context) {
    String? title = bookmark.ogTitle.isNotEmpty ? bookmark.ogTitle : null;
    title = bookmark.title.isNotEmpty ? bookmark.title : title;

    String? description =
        bookmark.ogDescription.isNotEmpty ? bookmark.ogDescription : null;
    description = bookmark.note.isNotEmpty ? bookmark.note : description;

    return Stack(
      children: [
        Card.filled(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => openUrl(bookmark.url),
            child: Row(
              children: [
                Expanded(
                    child: ListTile(
                        leading: bookmark.favicon.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: bookmark.favicon,
                                fit: BoxFit.contain,
                                width: 24,
                                height: 24,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.link),
                              )
                            : const Icon(Icons.link),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title != null)
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleMedium,
                              ),
                            if (description != null)
                              Text(
                                description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall,
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                bookmark.url,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleSmall?.copyWith(
                                    color: context.colorScheme.primary),
                              ),
                            ),
                          ],
                        ))),
                if (bookmark.ogImage.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: bookmark.ogImage,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            onPressed: () => showBookmarkDetailsDialog(bookmark),
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
