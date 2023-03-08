import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future handledAPI() async {
  List? data;
  int counter = 0;
  while (true) {
    counter++;
    if (counter <= 4) {
      try {
        data = await _getAPI().timeout(const Duration(seconds: 2));
        if (data == null) {
          continue;
        } else {
          break;
        }
      } on TimeoutException {
        data = null;
        continue;
      } catch (e) {
        data = null;
      }
    } else {
      break;
    }
  }
  return data;
}

Future<List?> _getAPI() async {
  Uri uri = Uri.parse('https://panel.game4study.com/api/v1/meta/weather');
  final client = HttpClient();
  final request = await client.getUrl(uri);
  final response = await request.close();
  final contentAsString = await utf8.decodeStream(response);
  final Map? map = json.decode(contentAsString);
  List results = [];

  if (map != null) {
    Map avmet = map['avmet-api'];
    if (avmet.containsKey('pressure')) {
      var pressure = avmet['pressure'];
      var ground = avmet['first_ground'];
      results.add(double.parse(pressure));
      results.add(double.parse(ground.toString()));
      results.add(avmet['time']);
    } else {
      return null;
    }
  }

  return results;
}
