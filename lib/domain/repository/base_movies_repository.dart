import '../../core/error/failure.dart';
import '../entities/movies.dart';
import 'package:dartz/dartz.dart';
abstract class BaseMoviesRepository{     //contract
  Future<Either<Failure,List<Movies>>> getNowPlaying();
  Future<Either<Failure,List<Movies>>> getPopular();
  Future<Either<Failure,List<Movies>>> getTopRated();
}