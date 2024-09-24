import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/video/video.dart';

///
Future<void> openBrowser(
    {required String youtubeId, required WidgetRef ref}) async {
  await ref
      .read(videoProvider.notifier)
      .updateVideoPlayedAt(youtubeId: youtubeId);

  final Uri url = Uri.parse('https://youtu.be/$youtubeId');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
