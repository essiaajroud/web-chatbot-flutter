import 'package:flutter/material.dart';
import '../about/about.dart';
import '../chat/chat.dart';
import '../chat/chaticon.dart';
import '../naviagtionbar/responavbar.dart';

class MyHomePage extends StatefulWidget {
  final String? authToken;
  const MyHomePage({super.key, required this.authToken});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChatOpen = false;

  void toggleChat() {
    setState(() {
      isChatOpen = !isChatOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            const NavigationBarTablet(),
            const About(),
            if (isChatOpen)
              Positioned(
                bottom: 50,
                right: 20,
                child: ChatWindow(
                  toggleVisibility: toggleChat,
                  authToken: widget.authToken,
                ),
              ),
          ],
        ),
        bottomNavigationBar: ChatIcon(toggleChat: toggleChat));
  }
}
