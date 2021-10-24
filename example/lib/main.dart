import 'package:flutter/material.dart';

import 'package:open_brewery_db_example/widget_examples.dart/get_brewery.dart';
import 'package:open_brewery_db_example/widget_examples.dart/list_breweries.dart';
import 'package:open_brewery_db_example/widget_examples.dart/search_breweries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB00),
        title: const Text(
          'Open Brewery DB Example',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListBreweries(),
                    ),
                  );
                },
                child: const Text('List Breweries'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GetBrewery(),
                    ),
                  );
                },
                child: const Text('Get Brewery'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchBreweries(),
                    ),
                  );
                },
                child: const Text('Search Breweries'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
