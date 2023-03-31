abstract class MoviesStates{}

class MoviesInitialState extends MoviesStates{}

class GetNowPlayingMoviesSuccessState extends MoviesStates{}
class GetNowPlayingMoviesErrorState extends MoviesStates{}
class GetNowPlayingMoviesLoadingState extends MoviesStates{}
