import 'package:flutter/material.dart';
import 'package:open_brewery_db/open_brewery_db.dart';

class GetBrewery extends StatefulWidget {
  const GetBrewery({
    Key? key,
  }) : super(key: key);

  @override
  State<GetBrewery> createState() => _GetBreweryState();
}

class _GetBreweryState extends State<GetBrewery> {
  late String idLookup;
  int? current;
  ButtonStyle selected =
      OutlinedButton.styleFrom(primary: const Color(0xffFFBB00));
  ButtonStyle unselected = OutlinedButton.styleFrom(primary: Colors.grey);

  @override
  void initState() {
    super.initState();
    idLookup = "sierra-nevada-brewing-co-chico";
    current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFBB00),
        title: const Text(
          'Get Brewery',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Brewery>(
        future: OpenBreweryDb.getBrewery(id: idLookup),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Brewery? b = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Brewery IDs to lookup',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        endIndent: 100,
                        indent: 100,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          style: current == 0 ? selected : unselected,
                          onPressed: () {
                            setState(() {
                              idLookup = "sierra-nevada-brewing-co-chico";
                              current = 0;
                            });
                          },
                          child: const Text('sierra-nevada-brewing-co-chico'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          style: current == 1 ? selected : unselected,
                          onPressed: () {
                            setState(() {
                              idLookup = "10-barrel-brewing-co-san-diego";
                              current = 1;
                            });
                          },
                          child: const Text('10-barrel-brewing-co-san-diego'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          style: current == 2 ? selected : unselected,
                          onPressed: () {
                            setState(() {
                              idLookup = "knee-deep-brewing-co-auburn";
                              current = 2;
                            });
                          },
                          child: const Text('knee-deep-brewing-co-auburn'),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Brewery Data Returned',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      endIndent: 100,
                      indent: 100,
                    ),
                    Text('Name: ${b!.name ?? "null"}'),
                    Text('breweryType: ${b.breweryType ?? "null"}'),
                    Text('street: ${b.street ?? "null"}'),
                    Text('address_2: ${b.address_2 ?? "null"}'),
                    Text('address_3: ${b.address_3 ?? "null"}'),
                    Text('city: ${b.city ?? "null"}'),
                    Text('state: ${b.state ?? "null"}'),
                    Text('countyProvince: ${b.countyProvince ?? "null"}'),
                    Text('postalCode: ${b.postalCode ?? "null"}'),
                    Text('country: ${b.country ?? "null"}'),
                    Text('longitude: ${b.longitude ?? "null"}'),
                    Text('latitude: ${b.latitude ?? "null"}'),
                    Text('phone: ${b.phone ?? "null"}'),
                    Text('websiteUrl: ${b.websiteUrl ?? "null"}'),
                    Text('updatedAt: ${b.updatedAt ?? "null"}'),
                    Text('createdAt: ${b.createdAt ?? "null"}'),
                  ],
                ),
              ],
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
