import 'package:cleanarchsession/core/error/failure.dart';
import 'package:cleanarchsession/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/movies.dart';
class GetPopularMoviesUseCase{
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure,List<Movies>>> execute() async
  {
    return await baseMoviesRepository.getPopular();
  }
}