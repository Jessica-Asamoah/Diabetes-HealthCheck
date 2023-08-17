import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=1lb apple'),
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
      appBar: AppBar(
        title: Text('API Data Display'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error occurred: ${snapshot.error}');
            } else {
              final data = snapshot.data;
              return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Text('Data fetched successfully:\n${json.encode(data)}'),
              );
            }
          },
        ),
      ),
    );
  }
}
