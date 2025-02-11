import 'package:EMS/utils/navbar_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBackground(),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Chennai, IN',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/clouds.png'),
                        ),
                        Text(
                          'Current Temperature:',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '25°C',
                          style: TextStyle(fontSize: 48),
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          child: bottomPartOfWeatherPage(width, height),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavbarPage(
        0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color(0xFF0D47A1),
              Color(0xFF000000),
              Color(0xFF000000),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomPartOfWeatherPage(double width, double height) {
    return Column(
      children: [
        Container(
          width: width * 0.8,
          height: height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: const Color.fromRGBO(255, 255, 255, 0.2),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.water_drop, color: Colors.white),
                  SizedBox(height: 5),
                  Text('Humidity', style: TextStyle(color: Colors.white)),
                  Text('60%', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.air, color: Colors.white),
                  SizedBox(height: 5),
                  Text('Wind', style: TextStyle(color: Colors.white)),
                  Text('15 km/h', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.thermostat, color: Colors.white),
                  SizedBox(height: 5),
                  Text('Pressure', style: TextStyle(color: Colors.white)),
                  Text('1013 hPa', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
        Text(
          'Today',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(255, 255, 255, 0.2),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Morning', style: TextStyle(color: Colors.white)),
                      Text('Min: 18°C', style: TextStyle(color: Colors.white)),
                      Image.asset('assets/clouds.png', width: 50, height: 50),
                      Text('Max: 22°C', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Afternoon', style: TextStyle(color: Colors.white)),
                      Text('Min: 20°C', style: TextStyle(color: Colors.white)),
                      Image.asset('assets/clouds.png', width: 50, height: 50),
                      Text('Max: 25°C', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Evening', style: TextStyle(color: Colors.white)),
                      Text('Min: 16°C', style: TextStyle(color: Colors.white)),
                      Image.asset('assets/clouds.png', width: 50, height: 50),
                      Text('Max: 20°C', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D47A1),
            Color(0xFF000000),
          ],
        ),
      ),
    );
  }
}
