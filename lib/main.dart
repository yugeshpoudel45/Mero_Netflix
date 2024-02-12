import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/pages/5.home_pages/main_page.dart';

import 'package:netflix/repo/trending_repo.dart';
import 'package:netflix/themes/dark_theme.dart';
import 'package:netflix/themes/light_theme.dart';

import 'blocs/cubit/trending_section_cubit.dart';
import 'pages/6.Inside_home_pages/trending_movies_page.dart';

void main() {
  runApp(const MyApp());
}
//TODO add the preserve and remove the native splash screen here, and also remove it after initialization.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingSectionCubit(TrendingRepo()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // themeMode: ThemeMode.light,
        themeMode: ThemeMode.light,
        title: AppConstants.appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        // home: const HomePage(),
        // home: const MainPage(),
        home: const TrendingMoviesPage(),
      ),
    );
  }
}


//padding: const EdgeInsets.symmetric(horizontal: 16),

//Red Color
//Ff0000

//Netflix Color:
//E50914
