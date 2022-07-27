part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class AddFavEvent extends FavoritesEvent{
  final Pokemon pokemon;

  AddFavEvent({required this.pokemon});
}

class RemoveFavEvent extends FavoritesEvent{
  final String pokemonName;

  RemoveFavEvent({required this.pokemonName});
}