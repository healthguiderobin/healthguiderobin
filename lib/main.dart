import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/clrs.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/methods.dart';
import 'app/widgets/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  ErrorWidget.builder = (details) => errorScreen(details);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  setupNotification();
  runApp(const MyApp());
}

void setupNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AwesomeNotifications().initialize(
    "resource://drawable/ic_notification",
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Health Guide',
        channelDescription: 'The Best Deal',
        defaultColor: AppClrs.kPrimaryClr,
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      )
    ],
    debug: true,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestFCMPermission();
    setupFirebaseListeners();
  }

  void requestFCMPermission() async {
    // NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // if (settings.authorizationStatus == AuthorizationStatus.denied) {
    //   // Optionally show a dialog here to guide the user to enable notifications in settings
    // } else if (settings.authorizationStatus == AuthorizationStatus.authorized ||
    //     settings.authorizationStatus == AuthorizationStatus.provisional) {
    //   // print("FCM notifications allowed.");
    // }
    Future.delayed(const Duration(seconds: 4), () {
      checkNotificationPermission();
    });
  }

  void checkNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      showPermissionDialog();
    }
  }

  void showPermissionDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Get.defaultDialog(
        title: "Enable Notifications",
        middleText: "This app needs notification permissions to work properly.",
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await AwesomeNotifications()
                  .requestPermissionToSendNotifications();
            },
            child: Text("Allow"),
          ),
        ],
      );
    });
  }

  void setupFirebaseListeners() {
    FirebaseMessaging.onBackgroundMessage(_fcmBgHandler);
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        createNotification(notification);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        createNotification(notification);
      }
    });
  }

  Future<void> _fcmBgHandler(RemoteMessage message) async {
    AwesomeNotifications().createNotificationFromJsonData(
      message.data,
    );
  }

  void createNotification(RemoteNotification notification) {
    String nTitile = notification.title ?? 'Title';
    String nBody = notification.body ?? 'Body';
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Methods.createUniqueId(),
        channelKey: 'basic_channel',
        title: nTitile,
        body: nBody,
        largeIcon: 'asset://assets/app_logo.png',
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppClrs.kBackgroundClr,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: AppClrs.kPrimaryClr,
            ),
          ),
          title: "Health Guide",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          builder: EasyLoading.init(),
          getPages: AppPages.routes,
        );
      },
    ); // dir
  }
}
