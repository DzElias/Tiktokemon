part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonLoading extends PokemonState {}
class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  PokemonLoaded( {required this.pokemons} );
}
