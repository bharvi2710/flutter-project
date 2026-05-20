import 'package:flutter/material.dart';
import 'fragment_holder.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (context, animation1, animation2) => FragmentHolder(), transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        }, transitionDuration: const Duration(seconds: 2)),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        
      decoration: const BoxDecoration(
      gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8, 
            colors: [
              Color.fromARGB(255, 33, 66, 145), 
              Color.fromARGB(255, 2, 2, 46), 
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
                SizedBox(height: 20),
                
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