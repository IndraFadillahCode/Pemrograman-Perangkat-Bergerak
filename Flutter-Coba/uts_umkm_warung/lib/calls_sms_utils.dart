import 'package:url_launcher/url_launcher.dart';

Future<void> launchCall(String phoneNumber) async {
  final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(callUri)) {
    await launchUrl(callUri);
  } else {
    throw 'Could not launch $callUri';
  }
}

Future<void> launchSMS(String phoneNumber, String message) async {
  final Uri smsUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
    queryParameters: {'body': message},
  );
  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    throw 'Could not launch $smsUri';
  }
}
