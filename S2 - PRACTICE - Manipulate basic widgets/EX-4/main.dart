import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget{
    final Color color;
    final String text;

    const CustomCard({
      Key? key,
      required this.color,
      required this.text,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: 600,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(16.0),
      // Padding inside the decoration
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0), // Rounded corners (optional)
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white,),textAlign: TextAlign.center,
      ),
    );
  }
}


void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(color: Colors.blue[100]!, text: 'OOP'),
              CustomCard(color: Colors.blue[300]!, text: 'DART'),
              CustomCard(color: Colors.blue[700]!, text: 'FLUTTER')
            ],
          ),
        ),
      ),
    ),
  );
}
