import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix/components/buttons/other_buttons/info_button.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../models/others/movie_crew_model.dart';
import '../../routes/app_route_constant.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().onFetchingMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailsErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is MovieDetailsLoadedState) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  final movie = state.movieDetailsModel;
                  final image = movie.posterPath;
                  String genres = "";
                  for (var i = 0; i < movie.genres!.length; i++) {
                    genres += movie.genres![i].name!;
                    if (i != movie.genres!.length - 1) {
                      genres += ", ";
                    }
                  }
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: mySize.height / 2.5,
                                width: double.maxFinite,
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/$image",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          movie.title!,
                                          style: myTextTheme.headlineSmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.bookmark_border_rounded),
                                            SizedBox(width: mySize.width / 24),
                                            const Icon(Icons.share_outlined),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: mySize.height / 80),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_half_rounded,
                                            color: myColorScheme.onTertiary,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            movie.popularity.toString(),
                                            style: myTextTheme.labelLarge!
                                                .copyWith(
                                              color: myColorScheme.onTertiary,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: myColorScheme.onTertiary,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(movie.releaseDate!.year
                                              .toString()),
                                          const SizedBox(width: 8),
                                          InfoButton(
                                            text: movie.spokenLanguages![0]
                                                .englishName!,
                                            func: () {},
                                          ),
                                          const SizedBox(width: 8),
                                          InfoButton(
                                            text: movie
                                                .productionCountries![0].name!,
                                            func: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          PlayButton(
                                            icon:
                                                Icons.play_circle_fill_outlined,
                                            text: "Play",
                                            func: () {},
                                            height: mySize.height / 16,
                                            width: mySize.width / 2.3,
                                          ),
                                          PlayButton(
                                            icon: Icons.download_outlined,
                                            text: "Download",
                                            func: () {},
                                            height: mySize.height / 16,
                                            width: mySize.width / 2.3,
                                            isFilled: false,
                                            isDownloadButton: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Genre: $genres",
                                        style: myTextTheme.labelLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      movie.overview.toString(),
                                      style: myTextTheme.bodySmall,
                                    ),
                                    SizedBox(height: mySize.height / 64),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Crew",
                                          style: myTextTheme.titleMedium!),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        height: 72,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (context, index) {
                                              final movieCredits =
                                                  movie.credits!;
                                              return MovieCrewModel(
                                                image: movieCredits
                                                    .crew![index].profilePath
                                                    .toString(),
                                                name: movieCredits
                                                    .crew![index].name
                                                    .toString(),
                                                role: movieCredits
                                                    .crew![index].job
                                                    .toString(),
                                              );
                                            }),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Cast",
                                          style: myTextTheme.titleMedium!),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        height: 72,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (context, index) {
                                              final movieCredits =
                                                  movie.credits!;
                                              return MovieCrewModel(
                                                image: movieCredits
                                                    .cast![index].profilePath
                                                    .toString(),
                                                name: movieCredits
                                                    .cast![index].name
                                                    .toString(),
                                                role: "Actor",
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const TabBar(
                            isScrollable: true,
                            tabs: [
                              Tab(
                                text: "Trailers",
                              ),
                              Tab(
                                text: "More Like This",
                              ),
                              Tab(
                                text: "Reviews",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    //-------------------------------Movie Trailers Section-------------------------------------------
                    const Center(
                        child: Text("Trailers Section is yet to be created")),
                    //-------------------------------Similar Movies Section-------------------------------------------
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 8,
                        bottom: 8,
                      ),
                      child: Wrap(
                        children: List.generate(6, (int movieIndex) {
                          var similarMovies = state
                              .movieDetailsModel.similar!.results![movieIndex];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.movieDetailsPage,
                                extra: similarMovies.id,
                              );
                            },
                            child: MovieCarouselModel(
                              width: mySize.width / 2.25,
                              height: mySize.height / 3.2,
                              image: similarMovies.posterPath.toString(),
                              rating: similarMovies.popularity!,
                            ),
                          );
                        }),
                      ),
                    ),
                    //-----------------------------Movie Reviews Section----------------------------------
                    const Center(
                        child: Text("Reviews Section is yet to be created")),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
