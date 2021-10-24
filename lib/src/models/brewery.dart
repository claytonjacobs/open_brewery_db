class Brewery {
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

  const Brewery({
    this.id,
    this.name,
    this.breweryType,
    this.street,
    this.address_2,
    this.address_3,
    this.city,
    this.state,
    this.countyProvince,
    this.postalCode,
    this.country,
    this.longitude,
    this.latitude,
    this.phone,
    this.websiteUrl,
    this.updatedAt,
    this.createdAt,
  });

  factory Brewery.fromJson(Map<String, dynamic> json) {
    return Brewery(
      id: json['id'],
      name: json['name'],
      breweryType: json['brewery_type'],
      street: json['street'],
      address_2: json['address_2'],
      address_3: json['address_3'],
      city: json['city'],
      state: json['state'],
      countyProvince: json['county_province'],
      postalCode: json['postal_code'],
      country: json['country'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      phone: json['phone'],
      websiteUrl: json['website_url'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}
