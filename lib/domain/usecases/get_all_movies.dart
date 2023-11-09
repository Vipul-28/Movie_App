import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/UseCases/usecase.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_param.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class GetAllMovies extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetAllMovies(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async {
    return await repository.getAllMovies();
  }
}