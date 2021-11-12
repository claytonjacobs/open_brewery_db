// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_brewery_db/src/models/brewery.dart';

const String _by_city = 'by_city';
const String _by_dist = 'by_dist';
const String _by_name = 'by_name';
const String _by_state = 'by_state';
const String _by_postal = 'by_postal';
const String _by_type = 'by_type';
const String _by_page = 'page';
const String _per_page = 'per_page';
const String _sort = 'sort';

/// BreweryType
/// --
/// Filter [byType] by type of brewery using [BreweryType].
///
/// ---
///
/// **Must be one of:**
/// - micro - Most craft breweries. For example, Samual Adams is still considered a micro brewery.
/// - nano - An extremely small brewery which typically only distributes locally.
/// - regional - A regional location of an expanded brewery. Ex. Sierra Nevada's Asheville, NC location.
/// - brewpub - A beer-focused restaurant or restaurant/bar with a brewery on-premise.
/// - planning - A brewery in planning or not yet opened to the public.
/// - contract - A brewery that uses another brewery's equipment.
/// - proprietor - Similar to contract brewing but refers more to a brewery incubator.
/// - closed - A location which has been closed.
///
/// **Example 1:**
/// ```dart
/// OpenBreweryDb.listBreweries(byType: BreweryType.micro)
/// ```
enum BreweryType {
  /// **micro** - Most craft breweries. For example, Samual Adams is still considered a micro brewery.
  micro,

  /// **nano** - An extremely small brewery which typically only distributes locally.
  nano,

  /// **regional** - A regional location of an expanded brewery. Ex. Sierra Nevada's Asheville, NC location.
  regional,

  /// **brewpub** - A beer-focused restaurant or restaurant/bar with a brewery on-premise.
  brewpub,

  /// **planning** - A brewery in planning or not yet opened to the public.
  planning,

  /// **contract** - A brewery that uses another brewery's equipment.
  contract,

  /// **proprietor** - Similar to contract brewing but refers more to a brewery incubator.
  proprietor,

  /// **closed** - A location which has been closed.
  closed,
}

/// SortFieldType
/// --
/// Sort the results by one or more fields using [SortFieldType] in the [sortFields] parameter.
///
/// Sortable fields include:
/// `id`, `name`, `type`, `street`, `city`, `state`, `country`, `longitude`, `latitude`, `phone`
///
/// ---
///
///**Example 1:**
/// ```dart
/// OpenBreweryDb.listBreweries(
///          sortFields: [SortFieldType.name, SortFieldType.address],
///        ),
///
/// ```
/// ---
///
/// **Example 2:**
/// ```dart
/// OpenBreweryDb.listBreweries(
///          sortFields: [SortFieldType.longitude, SortFieldType.type],
///        ),
///
/// ```
enum SortFieldType {
  id,
  name,
  type,
  street,
  city,
  state,
  country,
  longitude,
  latitude,
  phone,
}

/// Sort
/// --
/// Sort the results using [Sort] by one or more fields in the [sortOrder] parameter.
///
/// ---
///
/// **Must be one of:**
/// - [Sort.asc] for ascending order
/// - [Sort.desc] for descending order
///
/// **Example 1:**
/// ```dart
/// OpenBreweryDb.listBreweries(sortOrder: Sort.asc)
/// ```
enum Sort {
  /// Sort results in ascending order.
  asc,

  /// Sort results in decending order.
  desc,
}

class OpenBreweryDb {
  /// List Breweries
  /// --
  /// Returns a list of breweries.
  ///
  /// ---
  ///
  /// - byCity - Filter breweries by city.
  /// - byDist - Sort the results by distance from an origin point, using [LatLng].
  /// - byName - Filter breweries by name.
  /// - byState - Filter breweries by state. *Note: Full state name is required; no abbreviations. For the parameters, you can use underscores or url encoding for spaces.*
  /// - byPostal - Filter breweries by postal code. May be filtered by basic (5 digit) postal code or more precisely filtered by postal+4 (9 digit) code. *Note: If filtering by postal+4 the search must include either a hyphen or an underscore.*
  /// - byType - Filter by type of brewery using [BreweryType].
  /// - byPage - The offset or page of breweries to return.
  /// - perPage - Number of breweries to return each call. *Note: Default per page is 20. Max per page is 50.*
  /// - sortFields - Sort the results by one or more fields using [SortFieldType].
  /// - sortOrder - Sort the results by ascending or descending order using [Sort]
  ///
  static Future<List<Brewery>> listBreweries({
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
  }) async {
    Map<String, dynamic> _queryParameters = returnQueryParameters(
      byCity: byCity,
      byDist: byDist,
      byName: byName,
      byState: byState,
      byPostal: byPostal,
      byType: byType,
      byPage: byPage,
      perPage: perPage,
      sortFields: sortFields,
      sortOrder: sortOrder,
    );

    final uri = Uri.https(
      'api.openbrewerydb.org',
      '/breweries',
      _queryParameters,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List l = json.decode(response.body);
      List<Brewery> b = [];
      for (var e in l) {
        b.add(Brewery.fromJson(e));
      }
      return b;
    } else {
      throw Exception('Failed to load breweries');
    }
  }

  /// ## Get Brewery
  /// Get a single brewery.
  ///
  /// ---
  ///
  ///- id - supply brewery id
  ///
  /// ### Example
  ///
  ///```dart
  ///OpenBreweryDb.getBrewery(id: "sierra-nevada-brewing-co-chico")
  ///```
  static Future<Brewery> getBrewery({required String id}) async {
    final uri = Uri.https(
      'api.openbrewerydb.org',
      '/breweries/$id',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Brewery.fromJson(json.decode(response.body));
      // List l = json.decode(response.body);
    } else {
      throw Exception('Failed to load breweries');
    }
  }

  /// ## Search Breweries
  /// Search for breweries based on a search term.
  ///
  /// ---
  ///
  ///- query - required search term
  ///
  /// ### Example1
  ///
  ///```dart
  /// OpenBreweryDb.searchBreweries(query: "Chico California")
  ///```
  ///
  /// ### Example 2
  ///
  ///```dart
  /// OpenBreweryDb.searchBreweries(query: "East 20th Street")
  ///```
  static Future<List<Brewery>> searchBreweries({
    required String query,
  }) async {
    if (query.isNotEmpty) {
      Map<String, dynamic> _queryParameters = {'query': query};

      final uri = Uri.https(
        'api.openbrewerydb.org',
        '/breweries/search',
        _queryParameters,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List l = json.decode(response.body);
        List<Brewery> b = [];
        for (var e in l) {
          b.add(Brewery.fromJson(e));
        }
        return b;
      } else {
        throw Exception(
            'Failed to load breweries. Status code ${response.statusCode}');
      }
    } else {
      return [];
    }
  }
}

/// ## LatLng
/// Required when using [byDist]
///
///
/// ### Example
///```dart
/// OpenBreweryDb.listBreweries(
///         byDist: LatLng(latitude: 38.5816, longitude: -121.4944), // Sacramento, CA
///     ),
///```
class LatLng {
  final double latitude;
  final double longitude;

  LatLng({required this.latitude, required this.longitude});
}

Map<String, dynamic> returnQueryParameters({
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
}) {
  Map<String, dynamic>? qp = {};
  if (byCity != null) {
    qp[_by_city] = byCity;
  }
  if (byDist != null) {
    qp[_by_dist] = '${byDist.latitude},${byDist.longitude}';
  }
  if (byName != null) {
    qp[_by_name] = byName;
  }
  if (byState != null) {
    qp[_by_state] = byState;
  }
  if (byPostal != null) {
    qp[_by_postal] = byPostal;
  }
  if (byType != null) {
    qp[_by_type] = byType.toString().split('.').last;
  }
  if (byPage != null) {
    qp[_by_page] = byPage;
  }
  if (perPage != null) {
    if (perPage > 50) {
      throw Exception("Max per page is 50.");
    }
    if (perPage < 1) {
      throw Exception("Minimum per page is 1.");
    }
    // must be converted to string to avoid Uri.https error
    qp[_per_page] = perPage.toString();
  }
  if (sortFields.isNotEmpty) {
    String lastString =
        sortFields[sortFields.length - 1].toString().split('.').last;

    for (var s in sortFields) {
      String current = s.toString().split('.').last;
      if (lastString == current) {
        if (qp.containsKey(_sort)) {
          qp[_sort] += current;
        } else {
          qp[_sort] = current;
        }
      } else {
        if (qp.containsKey(_sort)) {
          qp[_sort] += current + ",";
        } else {
          qp[_sort] = current + ",";
        }
      }
    }
    if (sortOrder != null) {
      String so = sortOrder.toString().split('.').last;
      qp[_sort] += ':$so';
    }
  }
  return qp;
}
