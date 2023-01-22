import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../widgets/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  var date = DateTime.parse("2023-01-21");

  Future<List> getRequest() async {
    final number = "%2B17707626117";
    final creationDate = "1/21/2023";
    // final queryParameters = {
    //   "phoneNumber": "%2B16041231234",
    //   "creationDate": "1//21//2023"
    // };
    final String _url =
        "http://localhost:5000/getTextsByUserAndDay?phoneNumber=" +
            number +
            "&creationDate=" +
            creationDate;
    final Uri _uri = Uri.parse(_url);
    print("uri = " + _uri.toString());
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control_Allow_Origin': '*',
      'Access-Control-Allow-Credentials': 'true'
    };
    // var response1 = await http
    //     .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    // print("bruh");
    final response = await http.get(_uri, headers: headers);
    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("Request failed");
    }

    //encode Map to JSON
    var body = json.encode(response.body);

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List texts = [];
    for (var text in responseData) {
      texts.add(text["textmessage"]);
      // print(text["textmessage"]);
    }
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    // final messages = [];
    // for (var i = 99; i >= 0; i--) {
    //   messages.add({"text": "This is entry # $i", "date": DateTime.now()});
    // }
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
                      DateChip(date: date),
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
                      child: FutureBuilder(
                    future: getRequest(),
                    builder: ((context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        final messages = snapshot.data?.reversed.toList();
                        print(messages);
                        return ListView.builder(
                            itemCount: messages?.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            reverse: true,
                            itemBuilder: (context, index) {
                              var msg = messages?[index];
                              return BubbleNormal(
                                text: msg,
                                isSender: true,
                                color: Color(0xFF1B97F3),
                                tail: true,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            });
                      }
                    }),
                  ))
                ],
              ),
            )));
  }
}
