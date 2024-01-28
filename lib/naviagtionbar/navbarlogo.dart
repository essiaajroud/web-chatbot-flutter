import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height:120,
            width: 140,
            child: Image.asset('assets/logo.png'),
            
          );
  }
}