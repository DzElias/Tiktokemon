part of 'favorites_bloc.dart';

class FavoritesState {
  List<Pokemon> favorites = [];

  FavoritesState(this.favorites);

  FavoritesState copyWith( List<Pokemon>? favorites) {
    favorites = favorites ?? this.favorites;

    return FavoritesState(favorites);
  }
}
