import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String joke = 'Chuck Norris can divide by zero.';

  Future<void> getJoke() async {
    try {
      // Make the API call
      final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

      if (response.statusCode == 200) {
        // Extract the joke from the response
        setState(() {
          joke = jsonDecode(response.body)['value'];
        });
      } else {
        // Something went wrong
        setState(() {
          joke = 'Error getting joke:\nHttp status ${response.statusCode}';
        });
      }
    } catch (e) {
      // Handle any exception that might occur during the HTTP request
      setState(() {
        joke = 'Error getting joke:\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              joke,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getJoke,
              child: const Text('Next Joke'),
            ),
          ],
        ),
      ),
    );
  }
}
