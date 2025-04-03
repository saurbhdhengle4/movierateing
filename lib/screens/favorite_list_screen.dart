import 'package:demoibbmapp/models/movie_model.dart';
import 'package:demoibbmapp/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class FavoriteListScreen extends StatelessWidget {
  final List<Movie> movies;

  const FavoriteListScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = movies.where((movie) => movie.isFav).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: favoriteMovies.isEmpty
          ? Center(child: Text('No favorite movies found.'))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  leading: SizedBox(
                    height: 100,
                    width: 100,
                    child: movie.primaryImage.isNotEmpty
                        ? Image.network(movie.primaryImage)
                        : SizedBox.shrink(),
                  ),
                  title: Text(movie.primaryTitle),
                  subtitle: Text('${movie.startYear}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      movie.isFav = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '${movie.primaryTitle} removed from favorites')),
                      );
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
              },
            ),
    );
  }
}
