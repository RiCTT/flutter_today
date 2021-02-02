import 'package:shared_preferences/shared_preferences.dart';

// https://pub.dev/packages/shared_preferences


getStore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print(counter);
  await prefs.setInt('counter', counter);
}
