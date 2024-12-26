import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/core/utils/network_utils.dart';
import 'package:firebase_auth_ex/feature/bookmark/widget/bookmark_details_dialouge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';

/// Тайл для ListView закладок
class BookmarkListTileWidget extends StatelessWidget {
  const BookmarkListTileWidget({
    super.key,
    required this.bookmark,
  });

  final BookmarkModel bookmark;

  @override
  Widget build(BuildContext context) {
    //* Получаем заголовок закладки с фолбэком на заколовок из метаданных
    String? title = bookmark.ogTitle.isNotEmpty ? bookmark.ogTitle : null;
    title = bookmark.title.isNotEmpty ? bookmark.title : title;

    //* Получаем записку закладки с фолбэком на описание из метаданных
    String? description =
        bookmark.ogDescription.isNotEmpty ? bookmark.ogDescription : null;
    description = bookmark.note.isNotEmpty ? bookmark.note : null;

    //* Стэк чтобы кнопку More отобразить
    return Stack(
      children: [
        Card.filled(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.l),
          ),
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            //* При тыке на карточку открываем ссылку
            onTap: () => openUrl(bookmark.url),
            child: Row(
              //* Ряд с ListTile и картинкой
              //? Картинку не сую в trailing чтобы не обрезалась
              children: [
                //* ListTile на максимальную ширину
                Expanded(
                    child: ListTile(
                        //* Фавикон сайта
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
                        //* Заколовок, описание и ссылка в одной колонке
                        //? Не юзаю subtitle чтобы не было пустоты если ничего нет в title
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Заголовок
                            if (title != null)
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleMedium,
                              ),
                            //* Описание (заметка)
                            if (description != null)
                              Text(
                                description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall,
                              ),
                            //* Ссылка
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                bookmark.url,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                //* С цветом primary
                                style: context.textTheme.titleSmall?.copyWith(
                                    color: context.colorScheme.primary),
                              ),
                            ),
                          ],
                        ))),
                //* Если есть картина то ее в конец суем
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

        //* Кнопка more
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
