import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'messages.dart';
import 'dart:convert';

class ChatWindow extends StatefulWidget {
  final VoidCallback toggleVisibility;
  final String? authToken;
  const ChatWindow({Key? key, required this.toggleVisibility,required this.authToken})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  final TextEditingController _messageController = TextEditingController();
  late DialogFlowtter dialogFlowtter;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 450,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: Image.asset("assets/chat.png").image,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: widget.toggleVisibility,
                ),
              ],
            ),
            const Divider(),
            // Chat content
            Expanded(
                child: MessagesScreen(messages: messages)),
            // Chat input field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6.5, left: 6),
                        child: TextFormField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(fontSize: 14),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      sendMessage(_messageController.text);
                      _messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

    final msg = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/save-chat-message/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${widget.authToken}'
      },
      body: jsonEncode({'message': text}),
    );
    print('HTTP response: ${msg.statusCode}, body: ${msg.body}');

    if (msg.statusCode != 200) {
      print('Failed to save chat message. Error: ${msg.body}');
    }

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) {
        return;
      }else{
        setState(() {
        addMessage(response.message!);
      });
      }
      
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
