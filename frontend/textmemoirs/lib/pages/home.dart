import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

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
    for (var i = 0; i < 100; i++) {
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Left"),
                          DateChip(date: messages[0]["date"]),
                          const Text("Right"),
                        ],
                      ),
                      ListView.builder(
                          itemCount: messages.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
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
                          })
                    ],
                  ),
                ))));
  }
}
