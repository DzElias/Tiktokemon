part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}
class PokemonLoadedEvent extends PokemonEvent {
  final List<Pokemon> pokemons;

  PokemonLoadedEvent( { required this.pokemons });
}
