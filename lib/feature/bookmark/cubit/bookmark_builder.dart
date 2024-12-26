import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkBuilder extends StatelessWidget {
  final BlocWidgetBuilder<BookmarkState> builder;

  const BookmarkBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(builder: builder);
  }
}
