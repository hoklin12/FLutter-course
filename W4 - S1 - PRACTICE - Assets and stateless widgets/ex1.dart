import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
const IconData skateboarding_outlined = IconData(0xf39f, fontFamily: 'MaterialIcons');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Hobbies"),
          backgroundColor: Colors.purple.shade50,
        ),
        backgroundColor: Colors.grey[700],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            children: [
              HobbyCard(
                title: 'Travelling',
                icon: Icons.travel_explore,
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 10),
              HobbyCard(
                title: 'Skating',
                icon: Icons.skateboarding_outlined,
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  const HobbyCard({
    Key? key,
    required this.title,
    required this.icon,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
