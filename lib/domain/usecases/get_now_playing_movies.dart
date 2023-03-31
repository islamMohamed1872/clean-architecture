import 'package:cleanarchsession/core/error/failure.dart';
import 'package:cleanarchsession/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/movies.dart';
class GetNowPlayingMoviesUseCase{
  final BaseMoviesRepository baseMoviesRepository;

  GetNowPlayingMoviesUseCase(this.baseMoviesRepository);

  Future<Either<Failure,List<Movies>>> execute() async
  {
    return await baseMoviesRepository.getNowPlaying();
  }
}