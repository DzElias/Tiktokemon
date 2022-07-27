import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktokemon/src/bloc/favorites/favorites_bloc.dart';
import 'package:tiktokemon/src/bloc/pokemon/pokemon_bloc.dart';
import 'package:tiktokemon/src/pages/home.dart';
import 'package:tiktokemon/src/utils/api_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PokemonBloc(apiProvider: ApiProvider())),
        BlocProvider(create: (_) => FavoritesBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}