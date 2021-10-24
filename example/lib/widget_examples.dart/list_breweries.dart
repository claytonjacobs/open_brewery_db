import 'package:flutter/material.dart';
import 'package:open_brewery_db/open_brewery_db.dart';

class ListBreweries extends StatelessWidget {
  const ListBreweries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB00),
        title: const Text(
          'List Breweries',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Brewery>>(
        future: OpenBreweryDb.listBreweries(
          byCity: "Sacramento",
          sortFields: [SortFieldType.name],
          sortOrder: Sort.asc,
        ),
        // future: OpenBreweryDb.listBreweries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext c, int i) {
                Brewery b = snapshot.data?[i] as Brewery;
                return ListTile(
                  title: Text('${b.name}'),
                  subtitle: Text('${b.city}, ${b.state}'),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
