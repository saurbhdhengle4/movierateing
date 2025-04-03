import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  String id;
  String url;
  String primaryTitle;
  String originalTitle;
  String type;
  String description;
  String primaryImage;
  String? trailer;
  String? contentRating;
  bool isAdult;
  DateTime releaseDate;
  int startYear;
  int? endYear;
  int runtimeMinutes;
  List<String> genres;
  List<String> interests;
  List<String> countriesOfOrigin;
  dynamic externalLinks;
  List<String> spokenLanguages;
  dynamic filmingLocations;
  List<ProductionCompany> productionCompanies;
  dynamic budget;
  int grossWorldwide;
  double? averageRating;
  int numVotes;
  dynamic metascore;
  bool isFav;

  Movie({
    required this.isFav,
    required this.id,
    required this.url,
    required this.primaryTitle,
    required this.originalTitle,
    required this.type,
    required this.description,
    required this.primaryImage,
    this.trailer,
    this.contentRating,
    required this.isAdult,
    required this.releaseDate,
    required this.startYear,
    this.endYear,
    required this.runtimeMinutes,
    required this.genres,
    required this.interests,
    required this.countriesOfOrigin,
    this.externalLinks,
    required this.spokenLanguages,
    this.filmingLocations,
    required this.productionCompanies,
    this.budget,
    required this.grossWorldwide,
    this.averageRating,
    required this.numVotes,
    this.metascore,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"] ?? '',
        url: json["url"] ?? '',
        primaryTitle: json["primaryTitle"] ?? '',
        originalTitle: json["originalTitle"] ?? '',
        type: json["type"] ?? '',
        description: json["description"] ?? '',
        primaryImage: json["primaryImage"] ?? '',
        trailer: json["trailer"],
        contentRating: json["contentRating"],
        isAdult: json["isAdult"] ?? false,
        releaseDate: json["releaseDate"] != null
            ? DateTime.parse(json["releaseDate"])
            : DateTime.now(),
        startYear: json["startYear"] ?? 0,
        endYear: json["endYear"],
        runtimeMinutes: json["runtimeMinutes"] ?? 0,
        genres: List<String>.from(json["genres"]?.map((x) => x) ?? []),
        interests: List<String>.from(json["interests"]?.map((x) => x) ?? []),
        countriesOfOrigin:
            List<String>.from(json["countriesOfOrigin"]?.map((x) => x) ?? []),
        externalLinks: json["externalLinks"],
        spokenLanguages:
            List<String>.from(json["spokenLanguages"]?.map((x) => x) ?? []),
        filmingLocations: json["filmingLocations"],
        productionCompanies: List<ProductionCompany>.from(
            json["productionCompanies"]
                    ?.map((x) => ProductionCompany.fromJson(x)) ??
                []),
        budget: json["budget"],
        grossWorldwide: json["grossWorldwide"] ?? 0,
        averageRating: json["averageRating"]?.toDouble(),
        numVotes: json["numVotes"] ?? 0,
        metascore: json["metascore"],
        isFav: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "primaryTitle": primaryTitle,
        "originalTitle": originalTitle,
        "type": type,
        "description": description,
        "primaryImage": primaryImage,
        "trailer": trailer,
        "contentRating": contentRating,
        "isAdult": isAdult,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "startYear": startYear,
        "endYear": endYear,
        "runtimeMinutes": runtimeMinutes,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "interests": List<dynamic>.from(interests.map((x) => x)),
        "countriesOfOrigin":
            List<dynamic>.from(countriesOfOrigin.map((x) => x)),
        "externalLinks": externalLinks,
        "spokenLanguages": List<dynamic>.from(spokenLanguages.map((x) => x)),
        "filmingLocations": filmingLocations,
        "productionCompanies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "budget": budget,
        "grossWorldwide": grossWorldwide,
        "averageRating": averageRating,
        "numVotes": numVotes,
        "metascore": metascore,
      };
}

class ProductionCompany {
  String id;
  String name;

  ProductionCompany({
    required this.id,
    required this.name,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
