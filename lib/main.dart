import 'package:beon/screens/home.dart';
import 'package:beon/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'functional/user_secure_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

String token;
String recover;

Future<void> main() async {
  initializeDateFormatting('am');

  await FlutterDownloader.initialize(debug: true);
  WidgetsFlutterBinding.ensureInitialized();
  token = await UserSecureStorage().getToken();
  recover = await UserSecureStorage().getRecover();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // navigation bar color
      statusBarColor: Colors.white, // status bar color
    ));
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child),
      title: 'BeOn',
      debugShowCheckedModeBanner: false,
      home: (token != null && recover == "ok") ? HomePage() : Login(),
    );
  }
}
