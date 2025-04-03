import 'dart:convert';
import 'package:demoibbmapp/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieApiService {
  final String baseUrl = 'https://imdb236.p.rapidapi.com/imdb/search';
  final String apiKey = 'a1213e5eebmsh28f5d685bad735fp1c825djsn87cf919b9d66';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?type=movie&genre=Drama&rows=100&sortOrder=ASC&sortField=id'),
      headers: {
        'x-rapidapi-host': 'imdb236.p.rapidapi.com',
        'x-rapidapi-key': apiKey,
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
