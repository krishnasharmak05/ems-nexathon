import 'package:ems/main.dart';
import 'package:ems/utils/navbar_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'package:flutter/material.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<StatefulWidget> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  double? lat, long;
// lat: Range = [-90(Southern Hemisphere), +90]
// long: Range = [-180[Western Hemisphere], 180]
  int selectedIndex = 0;
  late mongo.Db db;
  late mongo.DbCollection collection;
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    _getLocation();
    initDB();
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

      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
      _showErrorDialog("Error retrieving location.");
    }
  }

  Future<void> initDB() async {
    try {
      db = await mongo.Db.create(
          '"mongodb+srv://Krishna:Krishna@acr-user-data.3el6t.mongodb.net/?retryWrites=true&w=majority&appName=ACR-user-data"');
      await db.open();
      collection = db.collection('credential');
    } catch (e) {
      debugPrint("Error connecting to the database: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  void pushItems(String yesOrNo) async {
    await collection
        .insertOne({"Latitude": lat, "Longitude": long, "Yes or No": yesOrNo});
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.green.shade300, Colors.green.shade600],
              center: Alignment.center,
              radius: 0.7,
            ),
            border: Border.all(
              color: Colors.green.shade800,
              width: 4.0,
            ),
          ),
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.35,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you experiencing an earthquake?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        pushItems("Yes");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Emergency Alert Sent!"),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: 0,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                        Navigator.pushNamed(context, "/HomePage");
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      child: Text(
                        "Yes",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        pushItems("No");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Emergency Alert Sent!"),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: 0,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                        Navigator.pushNamed(context, "/HomePage");
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red.shade700,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      child: Text(
                        "No",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: NavbarPage(4),
    );
  }
}
