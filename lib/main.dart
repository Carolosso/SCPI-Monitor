import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/providers/screen_index_provider.dart';
import 'package:test/views/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenIndexProvider()),
        ChangeNotifierProvider(create: (context) => AppViewModel()),
      ],
      child: MaterialApp(
        theme: Styles.themeData(true, context),
        home: const HomePage(),
      ),
    );
  }
}
