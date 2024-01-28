import 'package:chatbot_ui/centeredview/centeredview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});
  final String websiteUrl = 'https://linsoft.xyz/fr/';

  Future<void> _launchWebsite() async {
    final Uri uri = Uri.parse(websiteUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $websiteUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, SizingInformation) {
        var textAlignment =
            SizingInformation.deviceScreenType == DeviceScreenType.desktop
                ? TextAlign.left
                : TextAlign.center;
        double titleSize =
            SizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 20
                : 40;
        double descriptionSize =
            SizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 16
                : 21;
        return CenteredView(
          child: SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Divider(
                    color: Color.fromRGBO(198, 198, 198, 100),
                    height: 3,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'About us',
                    style: TextStyle(
                      color: const Color.fromRGBO(68, 68, 68, 1),
                      fontFamily: 'Lionel Text Genuine',
                      fontSize: titleSize,
                    ),
                    textAlign: textAlignment,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/chatbot.gif',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'LinSoft provides you this Chatbot to answer all your questions, \n        We hope that our intelligente chatbot can help you. ',
                    style: TextStyle(
                        color: const Color.fromARGB(206, 109, 108, 108),
                        fontFamily: 'Longhand Bold',
                        fontSize: descriptionSize),
                    textAlign: textAlignment,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _launchWebsite();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 205, 32, 39),
                            fixedSize: const Size(200, 30),
                          ),
                          child: const Text(
                            'visit website',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Helvetica',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Color.fromRGBO(198, 198, 198, 100),
                    height: 3,
                  ),
                ]),
          ),
        );
      },
    );
  }
}
