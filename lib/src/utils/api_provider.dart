import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktokemon/src/models/api_response.dart';
import 'package:tiktokemon/src/models/pokemon.dart';

class ApiProvider {
  
  final _apiUrl = "https://pokeapi.co/api/v2/pokemon/";
  final _imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/";

  final _dio = Dio();

  Future<List<Pokemon>> fetchPokemons() async {
    List<Pokemon> pokemons = [];
    
    try {
      Response response = await _dio.get(_apiUrl);
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      int count = 0;
      for(var result in apiResponse.results){
        count++;
        Response pokemonResponse = await _dio.get(result.url);
        Image image = Image(image: NetworkImage("$_imageUrl$count.png"));



        Pokemon pokemon = Pokemon.fromJson( pokemonResponse.data, image);
        pokemon.name = pokemon.name.capitalize();
        pokemons.add(pokemon);
        
        
      }
      
      return pokemons;
      
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return pokemons;
    }
  }

}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
}