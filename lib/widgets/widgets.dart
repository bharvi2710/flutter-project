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
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
    Color(0xFF050C9C),
    Color(0xFF3572EF),
    Color(0xFF3ABEF9),
    Color(0xFFA7E6FF),
    Color(0xFF00FFAB),
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
                  style: TextStyle(fontSize: 22,color: Colors.white),
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
                children: [Text('Copyright 2025-2026', style: TextStyle(color: Colors.white))],)],
            ),
          )
          
          
        ],
      ),

      )
      
      
      
    );
  }
}