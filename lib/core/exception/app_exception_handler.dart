import 'package:dio/dio.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/router/app_router_key.dart';
import 'package:firebase_auth_ex/feature/bookmark/exception/bookmark_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

abstract class AppExceptionHandler {
  static void handleException(dynamic error, [StackTrace? stackTrace]) {
    _logError(error, stackTrace);

    String errorMessage = _getHumanFriendlyErrorMessage(error);

    _showErrorSnackBar(errorMessage, stackTrace);
  }

  //TODO вынести мапу ошибок
  static String _getHumanFriendlyErrorMessage(dynamic error) {
    return switch (error) {
      String _ => error,
      BookmarkNotFoundException _ => 'Bookmark with given URL not found',
      DioException _ => 'Can\'t load site preview data',
      Exception _ => error.toString(),
      _ => 'Unexpected error: ${error.toString()}',
    };
  }

  static void _showErrorSnackBar(String message, [StackTrace? stackTrace]) {
    final context = AppRouterKey.rootKey.currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            if (stackTrace != null) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () =>
                    _showDetailedErrorDialog(context, message, stackTrace),
                child: const Text(
                  'Show details',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 30),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void _showDetailedErrorDialog(
      BuildContext context, String message, StackTrace stackTrace) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text('Error Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                message,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
              const SizedBox(height: 10),
              SelectableText(
                stackTrace.toString(),
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: context.colorScheme.onSurface),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: '$message\n\nStack Trace:\n${stackTrace.toString()}'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error details copied')),
              );
            },
            child: const Text('Copy All'),
          ),
        ],
      ),
    );
  }

  static void _logError(dynamic error, [StackTrace? stackTrace]) {
    print('Error occurred: $error');
    if (stackTrace != null) {
      print('Stack Trace: $stackTrace');
    }
  }
}
