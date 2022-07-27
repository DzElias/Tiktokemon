import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktokemon/src/models/pokemon.dart';
import 'package:tiktokemon/src/utils/api_provider.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final ApiProvider apiProvider;

  PokemonBloc({required this.apiProvider}) : super(PokemonLoading()) {
    on<PokemonLoadedEvent>((event, emit) {
      emit(PokemonLoaded(pokemons: event.pokemons));
    });
  }

  void fetchPokemons()async{
    List<Pokemon> pokemons = await apiProvider.fetchPokemons();
    add(PokemonLoadedEvent(pokemons: pokemons));
  }
}
