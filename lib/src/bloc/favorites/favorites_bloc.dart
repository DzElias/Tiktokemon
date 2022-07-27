import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktokemon/src/models/pokemon.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState([])) {
    on<AddFavEvent>((event, emit) {
      List<Pokemon> pokemons = state.favorites;

      var _ = pokemons.removeWhere((f) => f.name == event.pokemon.name);

      pokemons.add(event.pokemon);

      emit(state.copyWith(pokemons));
    });

    on<RemoveFavEvent>((event, emit) {
      List<Pokemon> pokemons = state.favorites;

      var _ = pokemons.removeWhere((f) => f.name == event.pokemonName);


      emit(state.copyWith(pokemons));
    });
  }
}
