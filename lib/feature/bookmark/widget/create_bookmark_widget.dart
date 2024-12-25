import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/core/utils/network_utils.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_state.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showCreateBookmarkWidget(BuildContext context, {BookmarkModel? bookmark}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Важный параметр
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.l),
      ),
    ),
    builder: (context) {
      // Получаем высоту клавиатуры
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      return AnimatedPadding(
        padding: EdgeInsets.only(
            bottom: keyboardHeight,
            top: AppPadding.l,
            left: AppPadding.l,
            right: AppPadding.l),
        duration: const Duration(milliseconds: 100),
        child: CreateBookmarkWidget(bookmark: bookmark),
      );
    },
  );
}

class CreateBookmarkWidget extends StatefulWidget {
  final BookmarkModel? bookmark;

  const CreateBookmarkWidget({super.key, this.bookmark});

  @override
  CreateBookmarkWidgetState createState() => CreateBookmarkWidgetState();
}

class CreateBookmarkWidgetState extends State<CreateBookmarkWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _folderController = TextEditingController();

  bool _isUrlValid = false;

  String? _selectedFolder;

  @override
  void initState() {
    super.initState();

    if (widget.bookmark != null) {
      _urlController.text = widget.bookmark!.url;
      _validateUrl(_urlController.text);

      _titleController.text = widget.bookmark!.title;
      _noteController.text = widget.bookmark!.note;
    }
  }

  void _validateUrl(String value) {
    setState(() {
      _isUrlValid = value.isNotEmpty;
    });
  }

  String? _getUrlErrorText() {
    if (!_isUrlValid) {
      return "Enter a valid URL";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'URL',
              errorText: _getUrlErrorText(),
              suffixIcon: TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(Icons.paste), Text('paste'.tr())],
                ),
                onPressed: () async {
                  final data = await Clipboard.getData(Clipboard.kTextPlain);
                  if (data != null) {
                    _urlController.text = data.text ?? '';
                    _validateUrl(_urlController.text);
                  }
                },
              ),
            ),
            onChanged: _validateUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Text('optional'.tr(), style: context.textTheme.bodySmall),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'title'.tr(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (value) => _selectedFolder = value,
            controller: _folderController,
            decoration: InputDecoration(
              labelText: 'folder'.tr(),
              suffixIcon: BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, state) => PopupMenuButton<String>(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_drop_down),
                      Text('select'.tr())
                    ],
                  ),
                  onSelected: (String value) {
                    setState(() {
                      _selectedFolder = value;
                      _folderController.text = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return state.folderList.map((String folder) {
                      return PopupMenuItem<String>(
                        value: folder,
                        child: Text(folder),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'note'.tr(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _isUrlValid ? _saveBookmark : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text('save'.tr()),
          ),
        ],
      ),
    );
  }

  _saveBookmark() async {
    if (!_isUrlValid) return;

    final bookmarkCubit = context.bookmarkListCubit;

    final url = _urlController.text.trim();
    final formattedUrl = ensureUrlScheme(url);
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final folder = _selectedFolder ?? '';

    final bookmark = BookmarkModel(
      url: formattedUrl,
      title: title,
      note: note,
      folder: folder,
      updatedAt: DateTime.now(),
    );

    bookmarkCubit.createBookmark(bookmark);

    context.pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
