import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const PrimaryColorLight = const Color(0xFFE8FFF5);

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

  final server_uri = "http://18.144.90.175:5000";
  final number = "%2B17707626117";
  final today = DateTime.now();
  late var creationDate = ValueNotifier<DateTime>(today);

  Future<List> getRequest() async {
    final String _url =
        "$server_uri/getTextsByUserAndDay?phoneNumber=$number&creationDate=${DateFormat('yMd').format(creationDate.value)}";
    final Uri _uri = Uri.parse(_url);
    print("uri = $_uri");
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control_Allow_Origin': '*',
      'Access-Control-Allow-Credentials': 'true'
    };
    final response = await http.get(_uri, headers: headers);

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("Error  ${response.statusCode}");
    }

    //encode Map to JSON
    // var body = json.encode(response.body);
    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List texts = [];
    for (var text in responseData) {
      texts.add(text["textmessage"]);
    }
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date;
    return Scaffold(
        backgroundColor: PrimaryColorLight,
        appBar: AppBar(
          title: const Text('TextMemoirs'),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 85.0),
                          child: Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: creationDate,
                                  builder: ((context, value, child) {
                                    return DateChip(date: creationDate.value);
                                  })),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Button(
                                buttonText: 'Date',
                                onPressed: () async => {
                                  date = (await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Color(
                                                  0xFF137a63), // header background color
                                              onPrimary: Colors
                                                  .white, // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime.now()))!,
                                  setState(() {
                                    creationDate.value = date;
                                  }),
                                },
                                colour: const Color(0xFF137a63),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
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
                          if (messages != null && messages.isNotEmpty) {
                            return ListView.builder(
                                itemCount: messages.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  var msg = messages[index];
                                  return BubbleNormal(
                                    text: msg,
                                    isSender: true,
                                    color: Color(0xFF137a63),
                                    tail: true,
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                });
                          } else {
                            return const Text("No texts for this day");
                          }
                        }
                      }),
                    ),
                  ))
                ],
              ),
            )));
  }
}
