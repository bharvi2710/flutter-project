import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
      decoration: const BoxDecoration(
      gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8, // Controls how far the blue glow spreads
            colors: [
              Color.fromARGB(255, 33, 66, 145), // The deep blue center glow
              Color.fromARGB(255, 2, 2, 46), // The near-black edges
            ],
            
          ),
        
  ),

        child: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [Text('v1.1'),],),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 150, height: 150),
                Text(
                  'My Library',
                  style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
              children: [Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('© Copyright 2025-2026', style: TextStyle(color: Colors.white))],)],
            ),
          )
          ],
      ),
      )    
    );
  }
}