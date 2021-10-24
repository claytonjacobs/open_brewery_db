import 'package:flutter/material.dart';
import 'package:open_brewery_db/open_brewery_db.dart';

class SearchBreweries extends StatefulWidget {
  const SearchBreweries({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBreweries> createState() => _SearchBreweriesState();
}

class _SearchBreweriesState extends State<SearchBreweries> {
  final queryTextController = TextEditingController();
  late String query;
  int? numberOfResults;
  @override
  void initState() {
    super.initState();
    query = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB00),
        title: const Text(
          'Search Breweries',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term'),
                  controller: queryTextController,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      setState(() => query = queryTextController.text);
                    },
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<Brewery>>(
            future: OpenBreweryDb.searchBreweries(query: query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext c, int i) {
                      Brewery b = snapshot.data?[i] as Brewery;
                      return ListTile(
                        title: HighlightQueryMatchesName(b: b, q: query),
                        subtitle: Text('${b.city}, ${b.state}'),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    queryTextController.dispose();
    super.dispose();
  }
}

class HighlightQueryMatchesName extends StatelessWidget {
  const HighlightQueryMatchesName({Key? key, required this.b, required this.q})
      : super(key: key);

  final Brewery b;
  final String q;

  @override
  Widget build(BuildContext context) {
    int? startName = b.name?.indexOf(q);
    if (startName != -1) {
      int length = q.length;
      List parts = [];
      parts = [
        b.name?.substring(0, startName!),
        b.name?.substring(startName!, length + startName),
        b.name?.substring(length + startName!, b.name?.length),
      ];
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: parts[0] as String),
            TextSpan(
              text: parts[1] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextSpan(text: parts[2] as String),
          ],
        ),
      );
    }
    return Text(b.name as String);
  }
}
