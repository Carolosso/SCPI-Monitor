import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/providers/navigation_view_model.dart';
import 'package:test/utils/navigation_service.dart';
import 'package:test/pages/home_page.dart';

Future<void> main() async {
  //splash screen
  await initApp();
  runApp(const MyApp());
  //onloaded remove splashscreen
  FlutterNativeSplash.remove();
}

initApp() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(),
          // create provider immediately, dont wait cuz we need it for AppViewModel
          // lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AppViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => ScreenIndexProvider()),
      ],
      child: MaterialApp(
          theme: Styles.themeData(),
          home: const HomePage(),
          navigatorKey: NavigationService.navigatorKey),
    );
  }
}
