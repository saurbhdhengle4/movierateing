import 'package:demoibbmapp/blocs/movie_bloc.dart';
import 'package:demoibbmapp/screens/favorite_list_screen.dart';
import 'package:demoibbmapp/screens/movie_detail_screen.dart';
import 'package:demoibbmapp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:badges/badges.dart' as badges;

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late MovieBloc _movieBloc;
  int _startIndex = 0;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(MovieApiService());
    _movieBloc.add(FetchMovies(_startIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _movieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          actions: [
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                int favoriteCount =
                    state.movies.where((movie) => movie.isFav).length;
                return IconButton(
                  icon: badges.Badge(
                    badgeContent: Text('$favoriteCount'),
                    child: Icon(Icons.favorite),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteListScreen(
                          movies: state.movies
                              .where((movie) => movie.isFav)
                              .toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.movies.isEmpty && !state.hasReachedMax) {
              return Center(child: CircularProgressIndicator());
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!state.hasReachedMax &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  _movieBloc.add(FetchMovies(_startIndex));
                  _startIndex += 100;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: state.hasReachedMax
                    ? state.movies.length
                    : state.movies.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.movies.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final movie = state.movies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 0.9, color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: movie.primaryImage.isEmpty
                                ? Icon(Icons.image_not_supported)
                                : Image.network(movie.primaryImage),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.primaryTitle),
                                StarRating(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  rating: movie.averageRating ?? 0.0,
                                  allowHalfRating: true,
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
