import 'package:demoibbmapp/models/movie_model.dart';
import 'package:demoibbmapp/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieEvent {}

class FetchMovies extends MovieEvent {
  final int startIndex;

  FetchMovies(this.startIndex);
}

class MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  MovieState({required this.movies, this.hasReachedMax = false});
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiService apiService;

  MovieBloc(this.apiService) : super(MovieState(movies: [])) {
    on<FetchMovies>((event, emit) async {
      try {
        final newMovies = await apiService.fetchMovies();
        emit(MovieState(
          movies: List.of(state.movies)..addAll(newMovies),
          hasReachedMax: newMovies.isEmpty,
        ));
      } catch (_) {
        print(_);
        emit(MovieState(movies: state.movies));
      }
    });
  }
}
