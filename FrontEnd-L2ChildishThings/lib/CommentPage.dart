// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Commentpage extends StatefulWidget {
  const Commentpage({super.key});

  @override
  State<Commentpage> createState() => _CommentpageState();
}

class _CommentpageState extends State<Commentpage> {
  Future<List<String>> _fetchComments() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/comments'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final comments = List<String>.from(data.map((item) => item['content']));
        return comments;
      } else {
        throw Exception(
            'Failed to fetch comments. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.withOpacity(
              0.7), // Set orange transparent background for app bar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          width: double.infinity, // Sets the width to fill the available space
          height: double.infinity, // Sets the height of the big box
          color: Colors.orange[200], // Sets the background color of the box

          child: FutureBuilder<List<String>>(
            future: _fetchComments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final comments = snapshot.data!;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      elevation: 2,
                      child: ListTile(
                        title: Text(comments[index]),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No comments found'),
                );
              }
            },
          ),
        ));
  }
}
