import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/entities/no_param.dart';
import 'package:movie_app/domain/usecases/get_all_movies.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_event.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_state.dart';

// In app_error.dart
import 'package:movie_app/domain/entities/app_error.dart';

// In movie_entity.dart
import 'package:movie_app/domain/entities/movie_entity.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetAllMovies? getAllMovies;
  final GetTrending getTrending;

  MovieTabbedBloc({
    required this.getAllMovies,
    required this.getTrending,
  }) : super(MovieTabbedInitial());

  @override
  Stream<MovieTabbedState> mapEventToState(
      MovieTabbedEvent event,
      ) async* {
    if (event is MovieTabChangedEvent) {
      Either<AppError, List<MovieEntity>> moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getAllMovies!(NoParams());
          break;
        default:
          throw Exception('Unsupported tab index');
      }
      yield moviesEither.fold(
            (l) => MovieTabLoadError(currentTabIndex: event.currentTabIndex),
            (movies) {
          return MovieTabChanged(
            currentTabIndex: event.currentTabIndex,
            movies: movies!,
          );
        },
      );
    }
  }
}