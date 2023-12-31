
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/UseCases/usecase.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/no_param.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';

class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUser(this._authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams noParams) async =>
      _authenticationRepository.logoutUser();
}