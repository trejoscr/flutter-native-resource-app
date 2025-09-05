import 'package:share_plus/share_plus.dart';

class SharePlugin {

  static void share(String link, String subject) {
    Share.share(
      link,
      subject: subject,
    );
  }

}
