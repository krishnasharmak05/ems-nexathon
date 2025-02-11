import 'package:EMS/emergency_page.dart';
import 'package:EMS/home_page.dart';
import 'package:EMS/info_page.dart';
// import 'package:EMS/loading_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  try{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: false);
  }catch(e){
    debugPrint(e.toString());
  }
  runApp(DevicePreview(builder: (context) => MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMS',
      navigatorKey: navigatorKey,
      theme: ThemeData
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          .dark(),
      initialRoute: "/LoadingPage",
      routes: {
        "/LoadingPage": (context) => const LoadingPage(),
        "/HomePage": (context) => const HomePage(),
        "/Emergency": (context) => const EmergencyPage(),
        "/Info": (context) => const InfoPage(),
        // "/Profile": (context) => const ProfilePage(),
      },
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
try{
    _setupFirebaseMessaging();
}catch(e){
  debugPrint("e.toString()");
}

    //   messaging.getToken().then((String? token) {
    //     debugPrint("FCM Device Token: $token"); // This is the device token
    //   });
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     if(message.notification != null){
    //       Navigator.pushNamed(context, "/Emergency");
    //     }
    //   });

    //   FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   if(message.notification != null){
    //       Navigator.pushNamed(context, "/Emergency");
    //     }
    // });
    // RemoteMessage? initialMessage = await messaging.getInitialMessage();
    // if (initialMessage != null) {
    //   Navigator.pushNamed(context, '/Emergency');
    // }
  }

  // static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  //   if(message.notification != null){
  //       Navigator.pushNamed(context, "/Emergency");
  //     }
  // }

  Future<void> _setupFirebaseMessaging() async {
    // Set up Firebase Messaging
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((String? token) {
      print(
          "FCM Device Token: $token"); // Optionally save the token for push notification
    });

    // Handle notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground notification received: ${message.notification?.title}');
      if (message.notification != null) {
        navigatorKey.currentState?.pushReplacementNamed('/Emergency');
      }
    });

    // Handle notifications when the app is in the background
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    // Handle notification when the app is launched via a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened via notification: ${message.notification?.title}');
      navigatorKey.currentState?.pushReplacementNamed('/Emergency');
    });

    // Handle terminated state when the app is launched by a notification
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      navigatorKey.currentState?.pushReplacementNamed('/Emergency');
    } else {
      // If no notification, navigate to the home screen after splash
      Future.delayed(Duration(seconds: 3), () {
        navigatorKey.currentState?.pushReplacementNamed('/HomePage');
      });
    }
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) {
    navigatorKey.currentState?.pushReplacementNamed('/Emergency');
    return Future.value();
  }

  Future pushHomePage() async {
    void ele = await _getLocation();
    await Future.delayed(const Duration(seconds: 4));
    await Navigator.pushReplacementNamed(context, "/HomePage");
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorDialog("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied.");
        _showErrorDialog("Location permission denied.");
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
      _showErrorDialog(
          "We cannot continue if you do not allow us to use your location.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK, I will give permission"),
              onPressed: () {
                Navigator.of(context).pop();
                _getLocation();
              },
            ),
            TextButton(
              child: Text("Exit"),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: pushHomePage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedHeader(),
                    const SizedBox(height: 20),
                    TweenAnimationBuilder<int>(
                      key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
                      duration: const Duration(seconds: 2),
                      tween: IntTween(
                          begin: 0,
                          end: "100+ Agencies are ready to help you...".length),
                      builder: (context, index, child) {
                        return Text(
                          "100+ Agencies are ready to help you..."
                              .substring(0, index),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      },
                      onEnd: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        if (context.mounted) {
                          setState(() {});
                        }
                      },
                    ).animate().fadeIn(duration: 2.seconds),
                  ],
                ),
              ),
            );
          } else {
            return Container(); // Return an empty container or any other widget when the future is complete
          }
        },
      ),
    );
  }
}

class AnimatedHeader extends StatefulWidget {
  @override
  _AnimatedHeaderState createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(15, 23, 42, 0.95),
        border: Border(
            bottom: BorderSide(color: Colors.blue.withOpacity(0.2), width: 1)),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(0, 4))
        ],
      ),
      // padding: EdgeInsets.all(1),
      child: Image.asset(
        "assets/logo.png",
        color: Colors.yellow,
        width: 50,
        height: 50,
      )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scaleXY(end: 1.2, duration: 2.seconds)
          .then()
          .scaleXY(end: 1.0, duration: 2.seconds),
    );
  }
}
