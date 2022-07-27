import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Map<String, Color> colors = {
  "grass": Colors.green.shade600,
  "fire": Colors.red,
  "water": Colors.blue,
  "bug": Colors.brown.shade400,
  "normal": Colors.deepOrange.shade400,
};

class Pokemon {
    Pokemon({
        required this.image,
        required this.name,
        required this.hp,
        required this.attack,
        required this.defense,
        required this.stats,
        required this.type,
        required this.color


    });

    Image image;
    Color color;
    String name;
    List<Stat> stats;
    String type;
    String hp;
    String attack;
    String defense;

    factory Pokemon.fromJson(Map<String, dynamic> json, Image image) => Pokemon(
        name: json["name"],
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        type: List<Type>.from(json["types"].map((x) => Type.fromJson(x)))[0].type.name,
        hp:    List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x)))[0].baseStat.toString(),
        attack:    List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x)))[1].baseStat.toString(),
        defense:    List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x)))[2].baseStat.toString(),
        image: image,
        color: colors[List<Type>.from(json["types"].map((x) => Type.fromJson(x)))[0].type.name] ?? Colors.white

      
    );
}



class Species {
    Species({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}



class Stat {
    Stat({
        required this.baseStat,
        required this.effort,
        required this.stat,
    });

    int baseStat;
    int effort;
    Species stat;

    factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
    };
}

class Type {
    Type({
        required this.slot,
        required this.type,
    });

    int slot;
    Species type;

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}
