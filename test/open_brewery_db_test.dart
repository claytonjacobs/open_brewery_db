import 'package:flutter_test/flutter_test.dart';

import 'package:open_brewery_db/open_brewery_db.dart';

void main() {
  test('Search Brewery', () async {
    Brewery r =
        await OpenBreweryDb.getBrewery(id: "sierra-nevada-brewing-co-chico");
    expect(r.name, "Sierra Nevada Brewing Co");
  });

  test('List Brewery', () async {
    List<Brewery> result =
        await OpenBreweryDb.listBreweries(byState: "California");
    for (Brewery r in result) {
      expect(r.state, "California");
    }
  });

  test('Search Breweries', () async {
    bool foundBrewery = false;
    String searchQuery = "Sierra";
    String breweryNameToFind = "Sierra Nevada Brewing Co";
    List<Brewery> result =
        await OpenBreweryDb.searchBreweries(query: searchQuery);
    for (Brewery r in result) {
      if (r.name == breweryNameToFind) {
        foundBrewery = true;
        expect(r.name, breweryNameToFind);
      }
    }
    if (!foundBrewery) {
      fail("Did not find brewery $breweryNameToFind");
    }
  });
}
