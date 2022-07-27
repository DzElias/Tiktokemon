import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tiktokemon/src/bloc/favorites/favorites_bloc.dart';
import 'package:tiktokemon/src/models/pokemon.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text("Mis favoritos", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),

        
      ),
      backgroundColor: Colors.white,

      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          List<Pokemon> favorites = state.favorites;
          return Padding(
              padding: const EdgeInsets.all(40),
              child: favorites.isNotEmpty ?  ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (_, i) {
                  Pokemon pokemon = favorites[i];
                  return FavoriteBox(pokemon: pokemon);
                },
              ) : const Center(child: Text("Elije a un pokemon para agregarlo!", style: TextStyle(color: Colors.black87,fontSize: 18, fontWeight: FontWeight.bold)))
            );
        },
      ),
    );
  }
}

class FavoriteBox extends StatelessWidget {
  const FavoriteBox({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: pokemon.color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 90,
                child: pokemon.image
              ),

              const SizedBox(
                width: 15,
              ),

              Text(pokemon.name, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
            ],
          ),

          GestureDetector(
            child: Icon(Icons.delete_outlined, color: Colors.white, size: 30,),
            onTap: (){
              Provider.of<FavoritesBloc>(context, listen: false).add(RemoveFavEvent(pokemonName: pokemon.name));
            },

          )

        ],
      ),
    );
  }
}