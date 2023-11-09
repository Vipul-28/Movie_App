import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_imple.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/check_if_movie_favorite.dart';
import 'package:movie_app/domain/usecases/delete_favorite_movies.dart';
import 'package:movie_app/domain/usecases/get_all_movies.dart';
import 'package:movie_app/domain/usecases/get_cast.dart';
import 'package:movie_app/domain/usecases/get_favorite_movies.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_block.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/videos/videos_bloc.dart';

final getItInstance =GetIt.I;
Future init() async{
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient((getItInstance())));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetAllMovies>(() => GetAllMovies(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
          () => MovieRepositoryImpl(getItInstance(),getItInstance()));
  getItInstance.registerLazySingleton<SearchMovies>(() =>SearchMovies((getItInstance())));
  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteMovies>(
          () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
          () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
          () => CheckIfFavoriteMovie(getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc:getItInstance()
  ));
  getItInstance.registerFactory(
        () => MovieTabbedBloc(
          getTrending: GetTrending(getItInstance()),
          getAllMovies: GetAllMovies(getItInstance())
    ),
  );
  getItInstance.registerFactory(() => MovieDetailBloc(getMovieDetail: getItInstance(),
  castBloc:getItInstance(),videosBloc: getItInstance(),favoriteBloc: getItInstance()
  ));

  getItInstance.registerFactory(
          () => CastBloc(
        getCast: getItInstance(),
      ),
  );
  getItInstance.registerFactory(
        () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );
      getItInstance.registerFactory(
        () => SearchMovieBloc(
      searchMovies: getItInstance(),
    )
      );

  getItInstance.registerFactory(() => FavoriteBloc(
    saveMovie: getItInstance(),
    checkIfFavoriteMovie: getItInstance(),
    deleteFavoriteMovie: getItInstance(),
    getFavoriteMovies: getItInstance(),
  ));

}