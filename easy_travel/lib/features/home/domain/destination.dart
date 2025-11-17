class Destination {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String country;
  final String city;

  Destination({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.country,
    required this.city,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      title: json['title'],
      posterPath: json['posterPath'],
      overview: json['overview'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'],
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      city: map['city'] ?? '',
      country: map['country'] ?? '',
    );
  }
}
