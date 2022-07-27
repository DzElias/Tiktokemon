import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tiktokemon/src/bloc/favorites/favorites_bloc.dart';
import 'package:tiktokemon/src/bloc/pokemon/pokemon_bloc.dart';
import 'package:tiktokemon/src/models/pokemon.dart';
import 'package:tiktokemon/src/pages/favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<PokemonBloc>(context, listen: false).fetchPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {

          if(state is PokemonLoaded){
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.pokemons.length,
              itemBuilder: (_, i) {
                Pokemon pokemon = state.pokemons[i];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: pokemon.color,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Row(
                                children: const [
                                  Text("Mis favoritos", style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold
                                  )),
                                  SizedBox(width: 10,),
                                  Icon(Icons.favorite_outline, color: Colors.white,size: 38,  )
                                ],
                              )
                        
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text("Pokemon nro ${i+1}", style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,

                            )),
                            Text(pokemon.name, style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,

                            )),
                            
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.34 + 150,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                                height: MediaQuery.of(context).size.height * 0.34,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      StatValueBox(name: "Attack", value: pokemon.attack, color: pokemon.color),
                                      StatValueBox(name: "Defense", value: pokemon.defense, color: pokemon.color)
                                    ],),
                                    const SizedBox(height: 15,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      StatValueBox(name: "HP", value: pokemon.hp, color: pokemon.color),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(color: Colors.black54, width: 0.3)
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        width: 133,
                                        child: Center(
                                          child: Text("Type: ${pokemon.type}", style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                          )),
                                        ),
                                      )
                                    ],),
                                    const SizedBox(height: 15,),

                                    MaterialButton(
                                      onPressed: (){
                                        Provider.of<FavoritesBloc>(context, listen: false).add(AddFavEvent(pokemon: pokemon));
                                      },
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      color: Colors.black54,
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text("Yo te elijo!", style: TextStyle(
                                            color: Colors.white, 
                                            fontWeight: FontWeight.bold
                                          )),
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Positioned(
                                top: 0,
                                child: Container(
                                  width: 200,
                                  child: pokemon.image,
                                ),
                              ),
                            ],
                          ),
                        )



                      ],
                    ),
                  )
                ); 
              }
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}

class StatValueBox extends StatelessWidget {
  const StatValueBox({
    Key? key, required this.name, required this.value, required this.color,
   
  }) : super(key: key);

  final String name;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              width: 75,
              child: Center(
                child: Text(name, style: const TextStyle(
                  color: Colors.white
                )),
              ),
            )
          ]
        ),
        Row(
          
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.black54, width: 0.3)
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(value, style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold
              )),
            )
          ]
        ),
      
      ],
    );
  }
}

