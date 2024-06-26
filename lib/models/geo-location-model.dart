class Geolocation {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String state;

  const Geolocation(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.country,
      required this.state});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      name: json['name'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      country: json['country'] ?? '',
      state: json['state'] ?? '',
    );
  }

//
// factory Geolocation.fromJson(Map<String, dynamic> json){
//   return switch (json){
//     {
//     'name': String name,
//     'latitude': double latitude,
//     'longitude': double longitude,
//     'country': String country,
//     'state': String state
//     } =>
//         Geolocation(
//           name: name,
//           latitude: latitude,
//           longitude: longitude,
//           country: country,
//           state: state,
//         ), _ => throw const FormatException('Failed to load GeoLocation')
//   };
// }
}
