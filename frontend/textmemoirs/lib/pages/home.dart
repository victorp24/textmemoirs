import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../widgets/button.dart';
import 'package:http/http.dart' as http;

const PrimaryColorLight = const Color(0xFFA1B0AB);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messages = [];
    for (var i = 99; i >= 0; i--) {
      messages.add({"text": "This is entry # $i", "date": DateTime.now()});
    }
    return Scaffold(
        backgroundColor: PrimaryColorLight,
        appBar: AppBar(
          title: const Text('TextMemoirs'),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Button(
                          buttonText: 'Previous',
                          onPressed: () => {},
                          colour: PrimaryColorLight,
                        ),
                      ),
                      DateChip(date: messages[0]["date"]),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Button(
                          buttonText: 'Next',
                          onPressed: () => {},
                          colour: PrimaryColorLight,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: messages.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var msg = messages[index];
                          return BubbleNormal(
                            text: msg["text"],
                            isSender: true,
                            color: Color(0xFF1B97F3),
                            tail: true,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          );
                        }),
                  )
                ],
              ),
            )));
  }
}
