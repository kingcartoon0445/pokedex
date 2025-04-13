import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/config/routes.dart';
import 'package:pokedex/dio/service_locator.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:pokedex/presentation/blocs/theme/theme_bloc.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_bloc.dart';
import 'package:pokedex/presentation/screens/home/home_screen.dart';

import 'presentation/blocs/theme/theme_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Đăng ký các BLoC
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>(),
        ),
        BlocProvider<PokemonDetailBloc>(
          create: (_) => getIt<PokemonDetailBloc>(),
        ),
        BlocProvider<TypeDetailBloc>(
          create: (_) => getIt<TypeDetailBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => getIt<HomeBloc>(),
        ),
        // BlocProvider<AuthBloc>(
        //   create: (_) => getIt<AuthBloc>(),
        // ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          // Xây dựng ứng dụng với chủ đề từ ThemeBloc
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            supportedLocales: const [
              Locale('en', ""), // English
              Locale('fr'), // French
              Locale('it'), // Italian
            ],
            locale: context.locale,
            theme: state.themeData, // Sử dụng theme từ state
            routes: AppRoutes.routes,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
