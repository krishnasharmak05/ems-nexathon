import 'package:EMS/models/icon_models.dart';
import 'package:flutter/material.dart';

class NavbarPage extends StatefulWidget {
  final int currentIcon;
  final BoxDecoration? decoration;
  const NavbarPage(this.currentIcon, {this.decoration, super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  List<IconModels> icons = [
    IconModels(
      id: 0,
      name: "Home",
      icon: Icons.home_outlined,
      color: Colors.white,
    ),
    IconModels(
        id: 1,
        name: "Info",
        icon: Icons.description_outlined,
        color: Colors.white),
  ];
  late int currentIcon;

  @override
  void initState() {
    super.initState();
    currentIcon = widget.currentIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // .fromARGB(255, 16, 63, 102)
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(158, 158, 158, 1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: icons
              .map(
                (icon) => Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        currentIcon = icon.id;
                      });
                      if (icon.id == 0) {
                        Navigator.pushReplacementNamed(context, "/HomePage");
                      } else {
                        await Navigator.pushNamed(context, '/${icon.name}');
                      }
                    },
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 900),
                      child: Icon(icon.icon,
                          size: currentIcon == icon.id ? 26 : 23,
                          color: currentIcon == icon.id
                              ? Colors.red // red
                              : Colors.black // black,
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
