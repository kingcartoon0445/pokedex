import 'dart:developer';

import 'package:pokedex/data/model_db/pokemon_model.dart';

class EvolutionChainModel {
  EvolvesTo? chain;

  EvolutionChainModel({this.chain});

  EvolutionChainModel.fromAPIJson(Map<String, dynamic> json) {
    chain = json['chain'] != null ? EvolvesTo.fromAPIJson(json['chain']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chain != null) {
      data['chain'] = chain!.toJson();
    }
    return data;
  }
}

class Trigger {
  String? name;
  String? url;

  Trigger({this.name, this.url});

  Trigger.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class EvolvesTo {
  Pokemon? pokemon;
  String? species;
  int? minLevel;
  int? min_happiness;
  int? min_beauty;
  bool? needs_overworld_rain;
  String? time_of_day;
  String? known_move;
  String? known_move_type;
  String? heldItem;
  String? item;
  String? trigger;
  List<EvolvesTo>? evolvesTo;

  EvolvesTo(
      {this.pokemon,
      this.species,
      this.minLevel,
      this.heldItem,
      this.item,
      this.trigger,
      this.evolvesTo,
      this.min_happiness,
      this.min_beauty,
      this.needs_overworld_rain,
      this.known_move,
      this.known_move_type,
      this.time_of_day});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    species = json['species'];
    minLevel = json['min_level'];
    heldItem = json['held_item'];
    item = json['item'];
    min_happiness = json['min_happiness'];
    min_beauty = json['min_beauty'];
    needs_overworld_rain = json['needs_overworld_rain'];
    known_move = json['known_move'] != null ? json['known_move']["name"] : null;
    known_move = json['known_move_type'] != null
        ? json['known_move_type']["name"]
        : null;
    time_of_day = json['time_of_day'];
    trigger = json['trigger'];
    if (json['evolves_to'] != null) {
      evolvesTo = <EvolvesTo>[];
      json['evolves_to'].forEach((v) {
        evolvesTo!.add(EvolvesTo.fromJson(v));
      });
    }
  }
  EvolvesTo.fromAPIJson(Map<String, dynamic> json) {
    int? minLevels;
    String? heldItems;
    String? items;
    String? triggers;

    for (var evolutionDetail in json["evolution_details"]) {
      minLevels = evolutionDetail['min_level'];
      heldItems = evolutionDetail['held_item'] != null
          ? evolutionDetail['held_item']["name"]
          : null;
      items = evolutionDetail['item'] != null
          ? evolutionDetail['item']["name"]
          : null;
      min_happiness = evolutionDetail['min_happiness'];
      min_beauty = evolutionDetail['min_beauty'];
      needs_overworld_rain = evolutionDetail['needs_overworld_rain'];
      known_move = evolutionDetail['known_move'] != null
          ? evolutionDetail['known_move']["name"]
          : null;
      known_move_type = evolutionDetail['known_move_type'] != null
          ? evolutionDetail['known_move_type']["name"]
          : null;
      time_of_day = evolutionDetail['time_of_day'];
      triggers = evolutionDetail['trigger']["name"];
    }
    var a = json["pokemon"];
    try {
      pokemon = a != null ? Pokemon.fromJson(a) : null;
    } catch (e) {
      try {
        var b = a['pokemon'];
        pokemon = Pokemon.fromJson(b);
      } catch (e) {
        log(e.toString());
      }
    }

    species = json['species']["name"];
    minLevel = minLevels;
    heldItem = heldItems;
    item = items;
    trigger = triggers;
    List<EvolvesTo> lst = [];
    if (json['evolves_to'] != null) {
      for (var element in json['evolves_to']) {
        lst.add(EvolvesTo.fromAPIJson(element));
      }
    }
    evolvesTo = lst;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['species'] = species;
    data['min_level'] = minLevel;
    data['held_item'] = heldItem;
    data['item'] = item;
    data['trigger'] = trigger;
    if (evolvesTo != null) {
      data['evolves_to'] = evolvesTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
