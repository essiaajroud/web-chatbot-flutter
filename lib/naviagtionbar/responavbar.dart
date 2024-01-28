import 'package:flutter/material.dart';
import '../sign in/signin.dart';
import 'navbarlogo.dart';

class NavigationBarTablet extends StatelessWidget {
  const NavigationBarTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //ColoredBox(color: ),
         const Padding(
            padding:  EdgeInsets.only(left: 120),
            child:  NavBarLogo(),
          ),
          const Row(
            children: [
              Text(
                'LinSoft ChatBot',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Lato',
                    color: Color.fromRGBO(68, 68, 68,10),
                    fontWeight: FontWeight.bold),
                    
              ),  
            ],
          ),
                Padding(
                  padding: const EdgeInsets.only(right: 120),
                  child: ElevatedButton(
                     onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:const Color.fromARGB(255, 205, 32, 39),
                              fixedSize: const Size(130, 30)
                            ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Helvetica',
                            color: Colors.white),
                      )),
                ),
            ],
      ),
    );
  }
}