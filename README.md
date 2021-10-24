Flutter/Dart API wrapper for [Open Brewery DB](https://www.openbrewerydb.org/).

> [Open Brewery DB](https://www.openbrewerydb.org/) is a free dataset and API with public information on breweries, cideries, brewpubs, and bottleshops. The goal of Open Brewery DB is to maintain an open-source, community-driven dataset and provide a public API. It is our belief that public information should be freely accessible for the betterment of the beer community and the happiness of web developers and data analysts.

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

## Features

| List Breweries                                                                                                                       | Get Brewery                                                                                                                       | Search Brewery                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/claytonjacobs/open_brewery_db/raw/main/example/assets/readme_images/list_breweries.gif" height="500" /> | <img src="https://github.com/claytonjacobs/open_brewery_db/raw/main/example/assets/readme_images/get_brewery.gif" height="500" /> | <img src="https://github.com/claytonjacobs/open_brewery_db/raw/main/example/assets/readme_images/search_breweries.gif" height="500" /> |

## Getting started

### Install

**Add package:**

```yaml
dependencies:
  open_brewery_db: ^0.0.1
```

**Run in your project directory**

```
$ flutter pub get
```

**Import it**

```dart
import 'package:open_brewery_db/open_brewery_db.dart';
```

---

## Usage

### Get Brewery by Id

#### Usage

```dart
Future<Brewery> getBrewery({required String id})
```

#### Example

```dart
OpenBreweryDb.getBrewery(id: "sierra-nevada-brewing-co-chico")
```

---

### List Breweries

#### Usage

```dart
Future<List<Brewery>> listBreweries({
    String? byCity,
    LatLng? byDist,
    String? byName,
    String? byState,
    String? byPostal,
    BreweryType? byType,
    int? byPage,
    int? perPage,
    List<SortFieldType> sortFields = const [],
    Sort? sortOrder,
  })
```

#### Examples

```dart
OpenBreweryDb.listBreweries(
          byCity: "Sacramento",
          sortFields: [SortFieldType.name],
          sortOrder: Sort.asc,
        ),
```

```dart
OpenBreweryDb.listBreweries(
          byState: "California",
          byCity: "San Diego",
          sortFields: [SortFieldType.street],
          sortOrder: Sort.desc,
        ),
```

```dart
OpenBreweryDb.listBreweries(
          byDist: LatLng(latitude: 38.5816, longitude: -121.4944), // Sacramento, CA
        ),
```

---

### Search Breweries

#### Usage

```dart
Future<List<Brewery>> searchBreweries({
    required String query,
  })
```

#### Examples

```dart
OpenBreweryDb.searchBreweries(query: "Sierra Nevada")
```

```dart
OpenBreweryDb.searchBreweries(query: "Chico California")
```

---

### Data

```dart
 Future<Brewery>
```

```dart
Future<List<Brewery>>
```

##### Brewery

```dart
  final String? id;
  final String? name;
  final String? breweryType;
  final String? street;
  final String? address_2;
  final String? address_3;
  final String? city;
  final String? state;
  final String? countyProvince;
  final String? postalCode;
  final String? country;
  final String? longitude;
  final String? latitude;
  final String? phone;
  final String? websiteUrl;
  final String? updatedAt;
  final String? createdAt;
```

---

## Roadmap

- [ ] Add [autocomplete](https://www.openbrewerydb.org/documentation/04-autocomplete) endpoint
- [ ] write tests for `get brewery`
- [ ] write tests for `list breweries`
- [ ] write tests for `search breweries`

---

## Additional information

Pull requests are very much welcomed!

[OBDB Frequently Asked Questions](https://www.openbrewerydb.org/faq)
