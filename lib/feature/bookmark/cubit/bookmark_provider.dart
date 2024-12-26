import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_state.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/local_bookmark_repository.dart';
import 'package:firebase_auth_ex/feature/bookmark/repository/remote_bookmark_repository.dart';
import 'package:firebase_auth_ex/feature/bookmark/service/preview_service.dart';
import 'package:firebase_auth_ex/feature/bookmark/service/sync_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkProvider extends BlocProvider<BookmarkCubit> {
  BookmarkProvider({super.key, required BuildContext context})
      : super(create: (_) {
          final appConfiguration = context.appConfig;
          final firestore = appConfiguration.state.firestoreInstance;
          final storage = appConfiguration.state.localStorageService;
          final dio = appConfiguration.state.dio;

          User? user;
          final authState = context.authCubit.state;
          if (authState is AuthStateAuthenticated) {
            user = authState.user;
          }

          final syncService = SyncService();
          final previewService = PreviewService(dio: dio);

          final localBookmarkRepository =
              LocalBookmarkRepository(storage: storage);

          RemoteBookmarkRepository? remoteBookmarkRepository;
          if (user != null) {
            remoteBookmarkRepository = RemoteBookmarkRepository(
                firestore: firestore, storage: storage, user: user);
          }

          return BookmarkCubit(
              remoteRepository: remoteBookmarkRepository,
              localRepository: localBookmarkRepository,
              syncService: syncService,
              previewService: previewService);
        });
}
