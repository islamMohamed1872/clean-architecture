import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleanarchsession/core/services/services_locator.dart';
import 'package:cleanarchsession/presentation/controller/movies_cubit.dart';
import 'package:cleanarchsession/presentation/controller/movies_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/network/api_constants.dart';
import '../../core/utils/dummy.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>getIt<MoviesCubit>()..getNowPlayingMovies()..getPopularMovies()..getTopRatedMovies(),
    child: BlocConsumer<MoviesCubit,MoviesStates>(
        builder: (context,state){
          MoviesCubit cubit = MoviesCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: SingleChildScrollView(
              key: const Key('movieScrollView'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 400.0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {},
                      ),
                      items: cubit.nowPlayingMovies.map(
                            (item) {
                          return GestureDetector(
                            key: const Key('openMovieMinimalDetail'),
                            onTap: () {
                              /// TODO : NAVIGATE TO MOVIE DETAILS
                            },
                            child: Stack(
                              children: [
                                ShaderMask(
                                  shaderCallback: (rect) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        // fromLTRB
                                        Colors.transparent,
                                        Colors.black,
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                      stops: [0, 0.3, 0.5, 1],
                                    ).createShader(
                                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                                    );
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: CachedNetworkImage(
                                    height: 560.0,
                                    imageUrl: ApiConstance.imageUrl(item.backdropPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              color: Colors.redAccent,
                                              size: 16.0,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              'Now Playing'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: Text(
                                          item.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /// TODO : NAVIGATION TO POPULAR SCREEN
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Text('See More',style: TextStyle(color: Colors.white),),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: cubit.popularMovies.length,
                        itemBuilder: (context, index) {
                          final movie = cubit.popularMovies[index];
                          return Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                /// TODO : NAVIGATE TO  MOVIE DETAILS
                              },
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                                child: CachedNetworkImage(
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                  imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(
                                      height: 170.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(
                      16.0,
                      24.0,
                      16.0,
                      8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Rated",
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.15,
                              color: Colors.white
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /// TODO : NAVIGATION TO Top Rated Movies Screen
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Text('See More',style: TextStyle(color: Colors.white),),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: cubit.topRatedMovies.length,
                        itemBuilder: (context, index) {
                          final movie = cubit.topRatedMovies[index];
                          return Container(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                /// TODO : NAVIGATE TO  MOVIE DETAILS
                              },
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                                child: CachedNetworkImage(
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                  imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(
                                      height: 170.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          );
        },
        listener: (context,state){}),);
  }
}
