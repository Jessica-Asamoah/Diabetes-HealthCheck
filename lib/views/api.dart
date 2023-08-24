import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestApi extends StatefulWidget {
  final String query;

  TestApi({required this.query});

  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.api-ninjas.com/v1/nutrition?query=${widget.query}'),
      headers: {"X-Api-Key": "5liSD9xaa1ETenbFFKwtkQ==OOg5VF1QvTXoXcQw"},
    ); // Replace with your API URL

    // Constructing the API URL with the API key and query as query parameters

    try {
      if (response.statusCode == 200) {
        // If the request is successful, parse the response JSON
        return json.decode(response.body);
      } else {
        // If the request fails, throw an exception or handle the error accordingly
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          "Do you really want to eat that?",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image_2023-06-09_13-38-14.png"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                SizedBox(
                  width: 329.0,
                  height: 203.0,
                  child: Card(
                    color: const Color(0xFFF4F4F4),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44.0)),
                    child: Center(
                      child: FutureBuilder<List<dynamic>>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error occurred: ${snapshot.error}');
                          } else {
                            final data = snapshot.data;
                            final calories =
                                data![0]["calories"]; // Extract the "age" value
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                  'The Estimated Calories are:\n$calories'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
