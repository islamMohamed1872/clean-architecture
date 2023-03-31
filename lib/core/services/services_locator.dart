import 'package:cleanarchsession/data/datasource/movie_remote_data_source.dart';
import 'package:cleanarchsession/data/repository/movies_repository.dart';
import 'package:cleanarchsession/domain/repository/base_movies_repository.dart';
import 'package:cleanarchsession/domain/usecases/get_now_playing_movies.dart';
import 'package:cleanarchsession/domain/usecases/get_popular_movies.dart';
import 'package:cleanarchsession/domain/usecases/get_top_rated_movies.dart';
import 'package:cleanarchsession/presentation/controller/movies_cubit.dart';
import 'package:cleanarchsession/presentation/controller/movies_states.dart';
import 'package:get_it/get_it.dart';

final getIt= GetIt.instance;

class ServicesLocator {
  void init(){

    getIt.registerFactory(() => MoviesCubit(getIt(), getIt(),getIt()));

    getIt.registerLazySingleton(() => GetNowPlayingMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopRatedMoviesUseCase(getIt()));

    getIt.registerLazySingleton<BaseMoviesRepository>(() => MoviesRepository(getIt()));

    getIt.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
  }
}