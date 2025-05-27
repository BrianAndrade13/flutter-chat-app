import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

    final String text;

  const Logo({super.key, required this.text});

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Container(
          width: 170,
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
        
              Image(image: AssetImage('assets/tag-logo.png')),
              SizedBox(height: 30),
              Text(text, style: TextStyle(fontSize: 20),)
        
            ],
          ),
        ),
      );
    }
  }