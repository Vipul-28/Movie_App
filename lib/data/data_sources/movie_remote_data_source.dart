import 'package:movie_app/data/core/api_client.dart';
import 'package:movie_app/data/models/cast_crew_result_data_model.dart';
import 'package:movie_app/data/models/movie_detail_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_result_data.dart';
import 'package:movie_app/data/models/video_model.dart';
import 'package:movie_app/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();

  Future<List<MovieModel>> getAllMovies();

  Future<List<MovieModel>> getSearchMovies(String searchTerm);

  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);

  Future<MovieDetailModel>getMovieDetail(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    try {
      final response = await _client.get('trending/movie/day');
      if (response != null ) {
        final movies = MoviesResultModel.fromJson(response).movies;
        print(movies);
        return movies!;
      } else {
        print('API response is null or has an unexpected structure');
        return [];
      }
    } catch (e) {print('An error occurred: $e');throw e;
    }
  }

  @override
  Future<List<MovieModel>> getAllMovies() async {
    try {
      final response = await _client.get('trending/movie/day');
      if (response != null ) {
        final movies = MoviesResultModel.fromJson(response).movies;
        print(movies);
        return movies!;
      } else {
        print('API response is null or has an unexpected structure');
        return [];
      }
    } catch (e) {print('An error occurred: $e');throw e;
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async{
    try {
      final response = await _client.get('movie/$id');
      if (response != null ) {
        final movies = MovieDetailModel.fromJson(response);
        print(movies);
        return movies;
      } else {
        print('API response is null or has an unexpected structure');
        throw Exception('API response has an unexpected structure');
      }
    } catch (e) {print('An error occurred: $e');throw e;
    }
  }


  @override
  Future<List<MovieModel>> getSearchMovies(String searchTerm) async {
    try {

      final response = await _client.get('search/movie', params: {
        'query': searchTerm??"",
      });
      if (response != null) {
        print("hello");
        final movies = MoviesResultModel.fromJson!(response).movies;
        print(movies);
        return movies!;
      } else {
        print('API response is null or has an unexpected structure');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      throw e;
    }
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    try {
      final response = await _client.get('movie/$id/credits');
      if (response != null ) {
        final movies = CastCrewResultModel.fromJson(response).cast;
        if (movies != null) {
          print(movies);
          return movies;
        } else {
          print('API response has null cast data');
          return [];
        }
      } else {
        print('API response is null or has an unexpected structure');
        return [];
      }
    } catch (e) {print('An error occurred: $e');throw e;
    }
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    try {
      final response = await _client.get('movie/$id/videos');
      if (response != null ) {
        final movies = VideoResultModel.fromJson(response).results;
        if (movies != null) {
          print(movies);
          return movies;
        } else {
          print('API response has null cast data');
          return [];
        }
      } else {
        print('API response is null or has an unexpected structure');
        return [];
      }
    } catch (e) {print('An error occurred: $e');throw e;
    }
  }

}
