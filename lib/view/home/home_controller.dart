import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:notif_pusher/view/home/detail.dart';

class HomeController extends GetxController {
  late FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel? channel;
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//! START on init
  @override
  void onInit() async {
    //init flutterlocal notif
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // ignore: todo
    //TODO 1. check WEB OR NOT
    // ignore: todo
    //TODO 2. await local notif plugin
    // ignore: todo
    //TODO 3. instance firebase
    // ignore: todo
    //TODO 4.
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );
      //?setting local notification
      await flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      //?Setting forground
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    //?func setting notif
    _notificationSetting();

    //?get token fcm
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("token :" + token.toString());
    });

    super.onInit();
  }
//! END ON INIT

  //!refrseh Token START
  Future refreshToken() async {
    String? newToken;
    FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      // newToken = token;
      // print(token.toString());
    });
    FirebaseMessaging.instance.getToken().then((value) {
      newToken = value;
    });
    print("new Token :" + newToken.toString());
  }
  //!REFRESH TOKEN END!!

  //!func notif setting START
  Future<void> _notificationSetting() async {
    //?firebase listen
    //?and show local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        //?init android setting
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('ic_stat_icon_camera');
        //?initiliaze setting
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);
        //?notif if clicked
        flutterLocalNotificationsPlugin!.initialize(
          initializationSettings,
          onSelectNotification: (message) => Get.to(() => const Detail(),
              arguments: [notification.title, notification.body]),
        );
        //?notif if show
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              icon: 'ic_stat_icon_camera',
              enableLights: true,
            ),
          ),
        );
      }
    });
  }
  //!func notif setting END
}
