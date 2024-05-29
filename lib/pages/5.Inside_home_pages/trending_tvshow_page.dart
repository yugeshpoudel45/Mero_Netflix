import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/trending_section_cubit.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../routes/app_route_constant.dart';

class TrendingTvShowsPage extends StatelessWidget {
  final TrendingSectionLoadedState loadedState;

  const TrendingTvShowsPage({super.key, required this.loadedState});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Tv Shows",
          style: myTextTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 8,
          bottom: 8,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(10, (int movieIndex) {
              var movie = loadedState.trendingTvShowModel.results![movieIndex];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    MyAppRouteConstants.tvShowDetailsPage,
                    extra: movie.id,
                  );
                },
                child: MovieCarouselModel(
                  width: mySize.width / 2.25,
                  height: mySize.height / 3.2,
                  image: movie.posterPath.toString(),
                  rating: movie.voteAverage!.toDouble(),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}