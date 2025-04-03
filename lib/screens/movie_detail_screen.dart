import 'package:demoibbmapp/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool? isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFav;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite!;
      widget.movie.isFav = isFavorite!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.primaryTitle),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ?? false ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ?? false ? Colors.red : Colors.grey,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.movie.primaryImage.isNotEmpty,
                child: SizedBox(
                  height: 100,
                  child: Image.network(widget.movie.primaryImage,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.movie.primaryTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.movie.startYear}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Genre: ${widget.movie.genres.join(', ')}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Plot Summary:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.movie.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'User Ratings: ${widget.movie.averageRating?.toStringAsFixed(1) ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Reviews:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'No reviews available.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
