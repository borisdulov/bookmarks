import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:url_launcher/url_launcher.dart';

bool isValidUrl(String url) {
  return Uri.tryParse(url)?.hasAbsolutePath ?? false;
}

String ensureUrlScheme(String inputUrl) {
  inputUrl = inputUrl.trim().toLowerCase();

  if (inputUrl.isEmpty) return '';

  if (!inputUrl.startsWith('http://') && !inputUrl.startsWith('https://')) {
    return 'https://$inputUrl';
  }

  return inputUrl;
}

Future<void> openUrl(String url) async {
  try {
    final Uri parsedUrl = Uri.parse(ensureUrlScheme(url));

    if (await canLaunchUrl(parsedUrl)) {
      await launchUrl(
        parsedUrl,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  } catch (e, stackTrace) {
    AppExceptionHandler.handleException(e, stackTrace);
  }
}
