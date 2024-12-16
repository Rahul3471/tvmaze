import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    final data = jsonDecode(response.body);

    setState(() {
      searchResults = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (text) {
                if (text.isNotEmpty) {
                  searchMovies(text);
                } else {
                  setState(() {
                    searchResults = [];
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? Center(child: Text('No results found'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = searchResults[index]['show'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/details',
                              arguments: movie);
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Image.network(movie['image']['medium'],
                                  height: 150),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  movie['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
