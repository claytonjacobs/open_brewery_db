// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_brewery_db/src/models/brewery.dart';

enum Filter {
  byCity,
  byDist,
  byName,
  byState,
  byPostal,
  byType,
  byPage,
}

const String _by_city = 'by_city';
const String _by_dist = 'by_dist';
const String _by_name = 'by_name';
const String _by_state = 'by_state';
const String _by_postal = 'by_postal';
const String _by_type = 'by_type';
const String _by_page = 'page';
const String _per_page = 'per_page';
const String _sort = 'sort';

enum BreweryType {
  micro,
  nano,
  regional,
  brewpub,
  large,
  planning,
  bar,
  contract,
  proprietor,
  closed,
}

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

enum Sort {
  asc,
  desc,
}

class OpenBreweryDb {
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
    qp[_per_page] = perPage;
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
