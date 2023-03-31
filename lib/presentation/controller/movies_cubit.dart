import 'package:cleanarchsession/data/datasource/movie_remote_data_source.dart';
import 'package:cleanarchsession/data/repository/movies_repository.dart';
import 'package:cleanarchsession/domain/repository/base_movies_repository.dart';
import 'package:cleanarchsession/domain/usecases/get_now_playing_movies.dart';
import 'package:cleanarchsession/domain/usecases/get_popular_movies.dart';
import 'package:cleanarchsession/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movies.dart';
import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit(this.getNowPlayingMoviesUseCase, this.getPopularMoviesUseCase, this.getTopRatedMoviesUseCase) : super(MoviesInitialState());
  static MoviesCubit get(context) => BlocProvider.of(context);
  List<Movies> nowPlayingMovies = [];
  List<Movies> popularMovies = [];
  List<Movies> topRatedMovies = [];
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  void getNowPlayingMovies() async {
    emit(GetNowPlayingMoviesLoadingState());


    final result = await getNowPlayingMoviesUseCase.execute();


    result.fold((l) => emit(GetNowPlayingMoviesErrorState()), (r) {
      nowPlayingMovies = r;
      emit(GetNowPlayingMoviesSuccessState());
    });
  }

  void getPopularMovies() async {
    emit(GetNowPlayingMoviesLoadingState());


    final result = await getPopularMoviesUseCase.execute();


    result.fold((l) => emit(GetNowPlayingMoviesErrorState()), (r) {
      popularMovies = r;
      emit(GetNowPlayingMoviesSuccessState());
    });
  }

  void getTopRatedMovies() async {
    emit(GetNowPlayingMoviesLoadingState());


    final result = await getTopRatedMoviesUseCase.execute();


    result.fold((l) => emit(GetNowPlayingMoviesErrorState()), (r) {
      topRatedMovies = r;
      emit(GetNowPlayingMoviesSuccessState());
    });
  }
}
