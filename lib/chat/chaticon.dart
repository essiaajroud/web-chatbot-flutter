import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChatIcon extends StatelessWidget {
  final VoidCallback toggleChat;

  const ChatIcon({super.key, required this.toggleChat});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, SizingInformation) {
      double paddingLeft =
          SizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? 1400
              : 600;
      double paddingBottom =
          SizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? 25
              : 30;
      double widthContainer =
          SizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? 60
              : 50;
      double heightContainer =
          SizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? 60
              : 50;
      return Padding(
        padding: EdgeInsets.only(left: paddingLeft, bottom: paddingBottom),
        child: Container(
          width: widthContainer,
          height: heightContainer,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 248, 195, 195),
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          child: ElevatedButton(
            child: Image.asset("assets/conv.png"),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
            ),
            onPressed: toggleChat,
          ),
        ),
      );
    });
  }
}
