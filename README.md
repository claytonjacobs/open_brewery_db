<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

| List Breweries                                                                                                                        | Get Brewery                                                                                                                        | Search Brewery                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/claytonjacobs/open_brewery_db/blob/main/example/assets/readme_images/list_breweries.gif" height="500" /> | <img src="https://github.com/claytonjacobs/open_brewery_db/blob/main/example/assets/readme_images/get_brewery.gif" height="500" /> | <img src="https://github.com/claytonjacobs/open_brewery_db/blob/main/example/assets/readme_images/search_breweries.gif" height="500" /> |

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

## Additional information

Pull requests are very much welcomed!
