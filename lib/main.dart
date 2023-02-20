import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Notifications/my_notifications.dart';
import 'Routes/routes.dart';
import 'Utils/Translation/translation.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  log('Notifications granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  onNotificationClickHandler();
  foregroundHandler();
  GetStorage authBox = GetStorage();
  messaging.getToken().then((value) {
    authBox.write('DeviceToken', value);
    log("Device Token --> $value");
  });
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bytrh',
      translations: Translation(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('en'), // English
      ],
      locale: const Locale("ar"),
      fallbackLocale: const Locale("ar"),
      theme: ThemeData(
        // canvasColor: Colors.transparent,
        // fontFamily: "arabic_font",
        fontFamily: "naskh_font",
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}



