import 'package:ems/utils/navbar_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.redAccent,
                height: MediaQuery.sizeOf(context).height * 0.28,
                child: Image.network(
                  "https://www.earthquakecountry.org/library/Drop_Cover_Hold_On_EN_Black_White_RGB.png",
                  height: MediaQuery.sizeOf(context).height * 0.28,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Earthquake Safety Tips",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Before an Earthquake:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "- Secure heavy items in your home (e.g., bookshelves, mirrors, light fixtures).\n"
                      "- Create a family emergency plan.\n"
                      "- Prepare an emergency kit with essential supplies.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "During an Earthquake:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "- Drop, Cover, and Hold On.\n"
                      "- Stay indoors until the shaking stops.\n"
                      "- Stay away from windows and heavy objects.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "After an Earthquake:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "- Check yourself and others for injuries.\n"
                      "- Be prepared for aftershocks.\n"
                      "- Follow your emergency plan and listen to local authorities.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavbarPage(1),
    );
  }
}
