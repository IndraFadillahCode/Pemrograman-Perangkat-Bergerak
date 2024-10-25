import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String address) async {
  final Uri mapUri = Uri(
    scheme: 'https',
    host: 'www.google.com',
    path: '/maps/search/',
    queryParameters: {'api': '1', 'query': address},
  );
  if (await canLaunchUrl(mapUri)) {
    await launchUrl(mapUri);
  } else {
    throw 'Could not open the map.';
  }
}
