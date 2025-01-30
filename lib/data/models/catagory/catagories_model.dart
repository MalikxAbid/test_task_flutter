import 'dart:convert';

class Catagories {
  String slug;
  String name;
  String url;

  Catagories({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory Catagories.fromRawJson(String str) => Catagories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Catagories.fromJson(Map<String, dynamic> json) => Catagories(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };
}
