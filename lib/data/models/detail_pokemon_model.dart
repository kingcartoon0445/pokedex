// class DetailPokemonModel {
//   // List<Abilities>? abilities;
//   int? baseExperience;
//   Cries? cries;
//   List<Forms>? forms;
//   // List<GameIndices>? gameIndices;
//   int? height;
//   // List<HeldItems>? heldItems;
//   int? id;
//   bool? isDefault;
//   // String? locationAreaEncounters;
//   List<Moves>? moves;
//   String? name;
//   int? order;
//   // List<String>? pastAbilities;
//   // List<String>? pastTypes;
//   Ability? species;
//   Sprites? sprites;
//   List<Stats>? stats;
//   List<Types>? types;
//   int? weight;

//   DetailPokemonModel(
//       {
//       // this.abilities,
//       this.baseExperience,
//       this.cries,
//       this.forms,
//       // this.gameIndices,
//       this.height,
//       // this.heldItems,
//       this.id,
//       this.isDefault,
//       // this.locationAreaEncounters,
//       // this.moves,
//       this.name,
//       this.order,
//       // this.pastAbilities,
//       // this.pastTypes,
//       this.species,
//       this.sprites,
//       this.stats,
//       this.types,
//       this.weight});

//   DetailPokemonModel.fromJson(Map<String, dynamic> json) {
//     // if (json['abilities'] != null) {
//     //   abilities = <Abilities>[];
//     //   json['abilities'].forEach((v) {
//     //     abilities!.add(Abilities.fromJson(v));
//     //   });
//     // }
//     baseExperience = json['base_experience'];
//     cries = json['cries'] != null ? Cries.fromJson(json['cries']) : null;
//     if (json['forms'] != null) {
//       forms = <Forms>[];
//       json['forms'].forEach((v) {
//         forms!.add(Forms.fromJson(v));
//       });
//     }
//     // if (json['game_indices'] != null) {
//     //   gameIndices = <GameIndices>[];
//     //   json['game_indices'].forEach((v) {
//     //     gameIndices!.add(GameIndices.fromJson(v));
//     //   });
//     // }
//     height = json['height'];
//     // if (json['held_items'] != null) {
//     //   heldItems = <HeldItems>[];
//     //   json['held_items'].forEach((v) {
//     //     heldItems!.add(HeldItems.fromJson(v));
//     //   });
//     // }
//     id = json['id'];
//     isDefault = json['is_default'];
//     // locationAreaEncounters = json['location_area_encounters'];
//     // if (json['moves'] != null) {
//     //   moves = <Moves>[];
//     //   json['moves'].forEach((v) {
//     //     moves!.add(Moves.fromJson(v));
//     //   });
//     // }
//     name = json['name'];
//     order = json['order'];
//     // if (json['past_abilities'] != null) {
//     //   pastAbilities = [];
//     //   json['past_abilities'].forEach((v) {
//     //     pastAbilities!.add(v);
//     //   });
//     // }
//     // if (json['past_types'] != null) {
//     //   pastTypes = [];
//     //   json['past_types'].forEach((v) {
//     //     pastTypes!.add(v);
//     //   });
//     // }
//     species =
//         json['species'] != null ? Ability.fromJson(json['species']) : null;
//     sprites =
//         json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
//     if (json['stats'] != null) {
//       stats = <Stats>[];
//       json['stats'].forEach((v) {
//         stats!.add(Stats.fromJson(v));
//       });
//     }
//     if (json['types'] != null) {
//       types = <Types>[];
//       json['types'].forEach((v) {
//         types!.add(Types.fromJson(v));
//       });
//     }
//     weight = json['weight'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // if (abilities != null) {
//     //   data['abilities'] = abilities!.map((v) => v.toJson()).toList();
//     // }
//     data['base_experience'] = baseExperience;
//     if (cries != null) {
//       data['cries'] = cries!.toJson();
//     }
//     if (forms != null) {
//       data['forms'] = forms!.map((v) => v.toJson()).toList();
//     }
//     // if (gameIndices != null) {
//     //   data['game_indices'] = gameIndices!.map((v) => v.toJson()).toList();
//     // }
//     data['height'] = height;
//     // if (heldItems != null) {
//     //   data['held_items'] = heldItems!.map((v) => v.toJson()).toList();
//     // }
//     data['id'] = id;
//     data['is_default'] = isDefault;
//     // data['location_area_encounters'] = locationAreaEncounters;
//     // if (moves != null) {
//     //   data['moves'] = moves!.map((v) => v.toJson()).toList();
//     // }
//     data['name'] = name;
//     data['order'] = order;
//     // if (pastAbilities != null) {
//     //   data['past_abilities'] = pastAbilities!.map((v) => v).toList();
//     // }
//     // if (pastTypes != null) {
//     //   data['past_types'] = pastTypes!.map((v) => v).toList();
//     // }
//     if (species != null) {
//       data['species'] = species!.toJson();
//     }
//     if (sprites != null) {
//       data['sprites'] = sprites!.toJson();
//     }
//     if (stats != null) {
//       data['stats'] = stats!.map((v) => v.toJson()).toList();
//     }
//     if (types != null) {
//       data['types'] = types!.map((v) => v.toJson()).toList();
//     }
//     data['weight'] = weight;
//     return data;
//   }
// }

// class Abilities {
//   Ability? ability;
//   bool? isHidden;
//   int? slot;

//   Abilities({this.ability, this.isHidden, this.slot});

//   Abilities.fromJson(Map<String, dynamic> json) {
//     ability =
//         json['ability'] != null ? Ability.fromJson(json['ability']) : null;
//     isHidden = json['is_hidden'];
//     slot = json['slot'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (ability != null) {
//       data['ability'] = ability!.toJson();
//     }
//     data['is_hidden'] = isHidden;
//     data['slot'] = slot;
//     return data;
//   }
// }

// class Ability {
//   String? name;
//   String? url;

//   Ability({this.name, this.url});

//   Ability.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['url'] = url;
//     return data;
//   }
// }

// class Cries {
//   String? latest;
//   String? legacy;

//   Cries({this.latest, this.legacy});

//   Cries.fromJson(Map<String, dynamic> json) {
//     latest = json['latest'];
//     legacy = json['legacy'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['latest'] = latest;
//     data['legacy'] = legacy;
//     return data;
//   }
// }

// class GameIndices {
//   int? gameIndex;
//   Ability? version;

//   GameIndices({this.gameIndex, this.version});

//   GameIndices.fromJson(Map<String, dynamic> json) {
//     gameIndex = json['game_index'];
//     version =
//         json['version'] != null ? Ability.fromJson(json['version']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['game_index'] = gameIndex;
//     if (version != null) {
//       data['version'] = version!.toJson();
//     }
//     return data;
//   }
// }

// class HeldItems {
//   Ability? item;
//   List<VersionDetails>? versionDetails;

//   HeldItems({this.item, this.versionDetails});

//   HeldItems.fromJson(Map<String, dynamic> json) {
//     item = json['item'] != null ? Ability.fromJson(json['item']) : null;
//     if (json['version_details'] != null) {
//       versionDetails = <VersionDetails>[];
//       json['version_details'].forEach((v) {
//         versionDetails!.add(VersionDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (item != null) {
//       data['item'] = item!.toJson();
//     }
//     if (versionDetails != null) {
//       data['version_details'] = versionDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VersionDetails {
//   int? rarity;
//   Ability? version;

//   VersionDetails({this.rarity, this.version});

//   VersionDetails.fromJson(Map<String, dynamic> json) {
//     rarity = json['rarity'];
//     version =
//         json['version'] != null ? Ability.fromJson(json['version']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['rarity'] = rarity;
//     if (version != null) {
//       data['version'] = version!.toJson();
//     }
//     return data;
//   }
// }

// class Moves {
//   Ability? move;
//   List<VersionGroupDetails>? versionGroupDetails;

//   Moves({this.move, this.versionGroupDetails});

//   Moves.fromJson(Map<String, dynamic> json) {
//     move = json['move'] != null ? Ability.fromJson(json['move']) : null;
//     if (json['version_group_details'] != null) {
//       versionGroupDetails = <VersionGroupDetails>[];
//       json['version_group_details'].forEach((v) {
//         versionGroupDetails!.add(VersionGroupDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (move != null) {
//       data['move'] = move!.toJson();
//     }
//     if (versionGroupDetails != null) {
//       data['version_group_details'] =
//           versionGroupDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VersionGroupDetails {
//   int? levelLearnedAt;
//   Ability? moveLearnMethod;
//   int? order;
//   Ability? versionGroup;

//   VersionGroupDetails(
//       {this.levelLearnedAt,
//       this.moveLearnMethod,
//       this.order,
//       this.versionGroup});

//   VersionGroupDetails.fromJson(Map<String, dynamic> json) {
//     levelLearnedAt = json['level_learned_at'];
//     moveLearnMethod = json['move_learn_method'] != null
//         ? Ability.fromJson(json['move_learn_method'])
//         : null;
//     order = json['order'];
//     versionGroup = json['version_group'] != null
//         ? Ability.fromJson(json['version_group'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['level_learned_at'] = levelLearnedAt;
//     if (moveLearnMethod != null) {
//       data['move_learn_method'] = moveLearnMethod!.toJson();
//     }
//     data['order'] = order;
//     if (versionGroup != null) {
//       data['version_group'] = versionGroup!.toJson();
//     }
//     return data;
//   }
// }

// class Sprites {
//   String? backDefault;
//   String? backFemale;
//   String? backShiny;
//   String? backShinyFemale;
//   String? frontDefault;
//   String? frontFemale;
//   String? frontShiny;
//   String? frontShinyFemale;
//   Other? other;
//   Versions? versions;

//   Sprites(
//       {this.backDefault,
//       this.backFemale,
//       this.backShiny,
//       this.backShinyFemale,
//       this.frontDefault,
//       this.frontFemale,
//       this.frontShiny,
//       this.frontShinyFemale,
//       this.other,
//       this.versions});

//   Sprites.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backFemale = json['back_female'];
//     backShiny = json['back_shiny'];
//     backShinyFemale = json['back_shiny_female'];
//     frontDefault = json['front_default'];
//     frontFemale = json['front_female'];
//     frontShiny = json['front_shiny'];
//     frontShinyFemale = json['front_shiny_female'];
//     other = json['other'] != null ? Other.fromJson(json['other']) : null;
//     versions =
//         json['versions'] != null ? Versions.fromJson(json['versions']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_female'] = backFemale;
//     data['back_shiny'] = backShiny;
//     data['back_shiny_female'] = backShinyFemale;
//     data['front_default'] = frontDefault;
//     data['front_female'] = frontFemale;
//     data['front_shiny'] = frontShiny;
//     data['front_shiny_female'] = frontShinyFemale;
//     if (other != null) {
//       data['other'] = other!.toJson();
//     }
//     if (versions != null) {
//       data['versions'] = versions!.toJson();
//     }
//     return data;
//   }
// }

// class Other {
//   DreamWorld? dreamWorld;
//   Home? home;
//   OfficialArtwork? officialArtwork;
//   Showdown? showdown;

//   Other({this.dreamWorld, this.home, this.officialArtwork, this.showdown});

//   Other.fromJson(Map<String, dynamic> json) {
//     dreamWorld = json['dream_world'] != null
//         ? DreamWorld.fromJson(json['dream_world'])
//         : null;
//     home = json['home'] != null ? Home.fromJson(json['home']) : null;
//     officialArtwork = json['official-artwork'] != null
//         ? OfficialArtwork.fromJson(json['official-artwork'])
//         : null;
//     showdown =
//         json['showdown'] != null ? Showdown.fromJson(json['showdown']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (dreamWorld != null) {
//       data['dream_world'] = dreamWorld!.toJson();
//     }
//     if (home != null) {
//       data['home'] = home!.toJson();
//     }
//     if (officialArtwork != null) {
//       data['official-artwork'] = officialArtwork!.toJson();
//     }
//     if (showdown != null) {
//       data['showdown'] = showdown!.toJson();
//     }
//     return data;
//   }
// }

// class DreamWorld {
//   String? frontDefault;
//   String? frontFemale;

//   DreamWorld({this.frontDefault, this.frontFemale});

//   DreamWorld.fromJson(Map<String, dynamic> json) {
//     frontDefault = json['front_default'];
//     frontFemale = json['front_female'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['front_default'] = frontDefault;
//     data['front_female'] = frontFemale;
//     return data;
//   }
// }

// class Home {
//   String? frontDefault;
//   String? frontFemale;
//   String? frontShiny;
//   String? frontShinyFemale;

//   Home(
//       {this.frontDefault,
//       this.frontFemale,
//       this.frontShiny,
//       this.frontShinyFemale});

//   Home.fromJson(Map<String, dynamic> json) {
//     frontDefault = json['front_default'];
//     frontFemale = json['front_female'];
//     frontShiny = json['front_shiny'];
//     frontShinyFemale = json['front_shiny_female'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['front_default'] = frontDefault;
//     data['front_female'] = frontFemale;
//     data['front_shiny'] = frontShiny;
//     data['front_shiny_female'] = frontShinyFemale;
//     return data;
//   }
// }

// class OfficialArtwork {
//   String? frontDefault;
//   String? frontShiny;

//   OfficialArtwork({this.frontDefault, this.frontShiny});

//   OfficialArtwork.fromJson(Map<String, dynamic> json) {
//     frontDefault = json['front_default'];
//     frontShiny = json['front_shiny'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['front_default'] = frontDefault;
//     data['front_shiny'] = frontShiny;
//     return data;
//   }
// }

// class Showdown {
//   String? backDefault;
//   String? backFemale;
//   String? backShiny;
//   String? backShinyFemale;
//   String? frontDefault;
//   String? frontFemale;
//   String? frontShiny;
//   String? frontShinyFemale;

//   Showdown(
//       {this.backDefault,
//       this.backFemale,
//       this.backShiny,
//       this.backShinyFemale,
//       this.frontDefault,
//       this.frontFemale,
//       this.frontShiny,
//       this.frontShinyFemale});

//   Showdown.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backFemale = json['back_female'];
//     backShiny = json['back_shiny'];
//     backShinyFemale = json['back_shiny_female'];
//     frontDefault = json['front_default'];
//     frontFemale = json['front_female'];
//     frontShiny = json['front_shiny'];
//     frontShinyFemale = json['front_shiny_female'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_female'] = backFemale;
//     data['back_shiny'] = backShiny;
//     data['back_shiny_female'] = backShinyFemale;
//     data['front_default'] = frontDefault;
//     data['front_female'] = frontFemale;
//     data['front_shiny'] = frontShiny;
//     data['front_shiny_female'] = frontShinyFemale;
//     return data;
//   }
// }

// class Versions {
//   GenerationI? generationI;
//   GenerationIi? generationIi;
//   GenerationIii? generationIii;
//   GenerationIv? generationIv;
//   GenerationV? generationV;
//   GenerationVi? generationVi;
//   GenerationVii? generationVii;
//   GenerationViii? generationViii;

//   Versions(
//       {this.generationI,
//       this.generationIi,
//       this.generationIii,
//       this.generationIv,
//       this.generationV,
//       this.generationVi,
//       this.generationVii,
//       this.generationViii});

//   Versions.fromJson(Map<String, dynamic> json) {
//     generationI = json['generation-i'] != null
//         ? GenerationI.fromJson(json['generation-i'])
//         : null;
//     generationIi = json['generation-ii'] != null
//         ? GenerationIi.fromJson(json['generation-ii'])
//         : null;
//     generationIii = json['generation-iii'] != null
//         ? GenerationIii.fromJson(json['generation-iii'])
//         : null;
//     generationIv = json['generation-iv'] != null
//         ? GenerationIv.fromJson(json['generation-iv'])
//         : null;
//     generationV = json['generation-v'] != null
//         ? GenerationV.fromJson(json['generation-v'])
//         : null;
//     generationVi = json['generation-vi'] != null
//         ? GenerationVi.fromJson(json['generation-vi'])
//         : null;
//     generationVii = json['generation-vii'] != null
//         ? GenerationVii.fromJson(json['generation-vii'])
//         : null;
//     generationViii = json['generation-viii'] != null
//         ? GenerationViii.fromJson(json['generation-viii'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (generationI != null) {
//       data['generation-i'] = generationI!.toJson();
//     }
//     if (generationIi != null) {
//       data['generation-ii'] = generationIi!.toJson();
//     }
//     if (generationIii != null) {
//       data['generation-iii'] = generationIii!.toJson();
//     }
//     if (generationIv != null) {
//       data['generation-iv'] = generationIv!.toJson();
//     }
//     if (generationV != null) {
//       data['generation-v'] = generationV!.toJson();
//     }
//     if (generationVi != null) {
//       data['generation-vi'] = generationVi!.toJson();
//     }
//     if (generationVii != null) {
//       data['generation-vii'] = generationVii!.toJson();
//     }
//     if (generationViii != null) {
//       data['generation-viii'] = generationViii!.toJson();
//     }
//     return data;
//   }
// }

// class GenerationI {
//   RedBlue? redBlue;
//   RedBlue? yellow;

//   GenerationI({this.redBlue, this.yellow});

//   GenerationI.fromJson(Map<String, dynamic> json) {
//     redBlue =
//         json['red-blue'] != null ? RedBlue.fromJson(json['red-blue']) : null;
//     yellow = json['yellow'] != null ? RedBlue.fromJson(json['yellow']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (redBlue != null) {
//       data['red-blue'] = redBlue!.toJson();
//     }
//     if (yellow != null) {
//       data['yellow'] = yellow!.toJson();
//     }
//     return data;
//   }
// }

// class RedBlue {
//   String? backDefault;
//   String? backGray;
//   String? backTransparent;
//   String? frontDefault;
//   String? frontGray;
//   String? frontTransparent;

//   RedBlue(
//       {this.backDefault,
//       this.backGray,
//       this.backTransparent,
//       this.frontDefault,
//       this.frontGray,
//       this.frontTransparent});

//   RedBlue.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backGray = json['back_gray'];
//     backTransparent = json['back_transparent'];
//     frontDefault = json['front_default'];
//     frontGray = json['front_gray'];
//     frontTransparent = json['front_transparent'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_gray'] = backGray;
//     data['back_transparent'] = backTransparent;
//     data['front_default'] = frontDefault;
//     data['front_gray'] = frontGray;
//     data['front_transparent'] = frontTransparent;
//     return data;
//   }
// }

// class GenerationIi {
//   Crystal? crystal;
//   Gold? gold;
//   Gold? silver;

//   GenerationIi({this.crystal, this.gold, this.silver});

//   GenerationIi.fromJson(Map<String, dynamic> json) {
//     crystal =
//         json['crystal'] != null ? Crystal.fromJson(json['crystal']) : null;
//     gold = json['gold'] != null ? Gold.fromJson(json['gold']) : null;
//     silver = json['silver'] != null ? Gold.fromJson(json['silver']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (crystal != null) {
//       data['crystal'] = crystal!.toJson();
//     }
//     if (gold != null) {
//       data['gold'] = gold!.toJson();
//     }
//     if (silver != null) {
//       data['silver'] = silver!.toJson();
//     }
//     return data;
//   }
// }

// class Crystal {
//   String? backDefault;
//   String? backShiny;
//   String? backShinyTransparent;
//   String? backTransparent;
//   String? frontDefault;
//   String? frontShiny;
//   String? frontShinyTransparent;
//   String? frontTransparent;

//   Crystal(
//       {this.backDefault,
//       this.backShiny,
//       this.backShinyTransparent,
//       this.backTransparent,
//       this.frontDefault,
//       this.frontShiny,
//       this.frontShinyTransparent,
//       this.frontTransparent});

//   Crystal.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backShiny = json['back_shiny'];
//     backShinyTransparent = json['back_shiny_transparent'];
//     backTransparent = json['back_transparent'];
//     frontDefault = json['front_default'];
//     frontShiny = json['front_shiny'];
//     frontShinyTransparent = json['front_shiny_transparent'];
//     frontTransparent = json['front_transparent'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_shiny'] = backShiny;
//     data['back_shiny_transparent'] = backShinyTransparent;
//     data['back_transparent'] = backTransparent;
//     data['front_default'] = frontDefault;
//     data['front_shiny'] = frontShiny;
//     data['front_shiny_transparent'] = frontShinyTransparent;
//     data['front_transparent'] = frontTransparent;
//     return data;
//   }
// }

// class Gold {
//   String? backDefault;
//   String? backShiny;
//   String? frontDefault;
//   String? frontShiny;
//   String? frontTransparent;

//   Gold(
//       {this.backDefault,
//       this.backShiny,
//       this.frontDefault,
//       this.frontShiny,
//       this.frontTransparent});

//   Gold.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backShiny = json['back_shiny'];
//     frontDefault = json['front_default'];
//     frontShiny = json['front_shiny'];
//     frontTransparent = json['front_transparent'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_shiny'] = backShiny;
//     data['front_default'] = frontDefault;
//     data['front_shiny'] = frontShiny;
//     data['front_transparent'] = frontTransparent;
//     return data;
//   }
// }

// class GenerationIii {
//   OfficialArtwork? emerald;
//   FireredLeafgreen? fireredLeafgreen;
//   FireredLeafgreen? rubySapphire;

//   GenerationIii({this.emerald, this.fireredLeafgreen, this.rubySapphire});

//   GenerationIii.fromJson(Map<String, dynamic> json) {
//     emerald = json['emerald'] != null
//         ? OfficialArtwork.fromJson(json['emerald'])
//         : null;
//     fireredLeafgreen = json['firered-leafgreen'] != null
//         ? FireredLeafgreen.fromJson(json['firered-leafgreen'])
//         : null;
//     rubySapphire = json['ruby-sapphire'] != null
//         ? FireredLeafgreen.fromJson(json['ruby-sapphire'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (emerald != null) {
//       data['emerald'] = emerald!.toJson();
//     }
//     if (fireredLeafgreen != null) {
//       data['firered-leafgreen'] = fireredLeafgreen!.toJson();
//     }
//     if (rubySapphire != null) {
//       data['ruby-sapphire'] = rubySapphire!.toJson();
//     }
//     return data;
//   }
// }

// class FireredLeafgreen {
//   String? backDefault;
//   String? backShiny;
//   String? frontDefault;
//   String? frontShiny;

//   FireredLeafgreen(
//       {this.backDefault, this.backShiny, this.frontDefault, this.frontShiny});

//   FireredLeafgreen.fromJson(Map<String, dynamic> json) {
//     backDefault = json['back_default'];
//     backShiny = json['back_shiny'];
//     frontDefault = json['front_default'];
//     frontShiny = json['front_shiny'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['back_default'] = backDefault;
//     data['back_shiny'] = backShiny;
//     data['front_default'] = frontDefault;
//     data['front_shiny'] = frontShiny;
//     return data;
//   }
// }

// class GenerationIv {
//   Showdown? diamondPearl;
//   Showdown? heartgoldSoulsilver;
//   Showdown? platinum;

//   GenerationIv({this.diamondPearl, this.heartgoldSoulsilver, this.platinum});

//   GenerationIv.fromJson(Map<String, dynamic> json) {
//     diamondPearl = json['diamond-pearl'] != null
//         ? Showdown.fromJson(json['diamond-pearl'])
//         : null;
//     heartgoldSoulsilver = json['heartgold-soulsilver'] != null
//         ? Showdown.fromJson(json['heartgold-soulsilver'])
//         : null;
//     platinum =
//         json['platinum'] != null ? Showdown.fromJson(json['platinum']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (diamondPearl != null) {
//       data['diamond-pearl'] = diamondPearl!.toJson();
//     }
//     if (heartgoldSoulsilver != null) {
//       data['heartgold-soulsilver'] = heartgoldSoulsilver!.toJson();
//     }
//     if (platinum != null) {
//       data['platinum'] = platinum!.toJson();
//     }
//     return data;
//   }
// }

// class GenerationV {
//   BlackWhite? blackWhite;

//   GenerationV({this.blackWhite});

//   GenerationV.fromJson(Map<String, dynamic> json) {
//     blackWhite = json['black-white'] != null
//         ? BlackWhite.fromJson(json['black-white'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (blackWhite != null) {
//       data['black-white'] = blackWhite!.toJson();
//     }
//     return data;
//   }
// }

// class BlackWhite {
//   Showdown? animated;
//   String? backDefault;
//   String? backFemale;
//   String? backShiny;
//   String? backShinyFemale;
//   String? frontDefault;
//   String? frontFemale;
//   String? frontShiny;
//   String? frontShinyFemale;

//   BlackWhite(
//       {this.animated,
//       this.backDefault,
//       this.backFemale,
//       this.backShiny,
//       this.backShinyFemale,
//       this.frontDefault,
//       this.frontFemale,
//       this.frontShiny,
//       this.frontShinyFemale});

//   BlackWhite.fromJson(Map<String, dynamic> json) {
//     animated =
//         json['animated'] != null ? Showdown.fromJson(json['animated']) : null;
//     backDefault = json['back_default'];
//     backFemale = json['back_female'];
//     backShiny = json['back_shiny'];
//     backShinyFemale = json['back_shiny_female'];
//     frontDefault = json['front_default'];
//     frontFemale = json['front_female'];
//     frontShiny = json['front_shiny'];
//     frontShinyFemale = json['front_shiny_female'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (animated != null) {
//       data['animated'] = animated!.toJson();
//     }
//     data['back_default'] = backDefault;
//     data['back_female'] = backFemale;
//     data['back_shiny'] = backShiny;
//     data['back_shiny_female'] = backShinyFemale;
//     data['front_default'] = frontDefault;
//     data['front_female'] = frontFemale;
//     data['front_shiny'] = frontShiny;
//     data['front_shiny_female'] = frontShinyFemale;
//     return data;
//   }
// }

// class GenerationVi {
//   Home? omegarubyAlphasapphire;
//   Home? xY;

//   GenerationVi({this.omegarubyAlphasapphire, this.xY});

//   GenerationVi.fromJson(Map<String, dynamic> json) {
//     omegarubyAlphasapphire = json['omegaruby-alphasapphire'] != null
//         ? Home.fromJson(json['omegaruby-alphasapphire'])
//         : null;
//     xY = json['x-y'] != null ? Home.fromJson(json['x-y']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (omegarubyAlphasapphire != null) {
//       data['omegaruby-alphasapphire'] = omegarubyAlphasapphire!.toJson();
//     }
//     if (xY != null) {
//       data['x-y'] = xY!.toJson();
//     }
//     return data;
//   }
// }

// class GenerationVii {
//   DreamWorld? icons;
//   Home? ultraSunUltraMoon;

//   GenerationVii({this.icons, this.ultraSunUltraMoon});

//   GenerationVii.fromJson(Map<String, dynamic> json) {
//     icons = json['icons'] != null ? DreamWorld.fromJson(json['icons']) : null;
//     ultraSunUltraMoon = json['ultra-sun-ultra-moon'] != null
//         ? Home.fromJson(json['ultra-sun-ultra-moon'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (icons != null) {
//       data['icons'] = icons!.toJson();
//     }
//     if (ultraSunUltraMoon != null) {
//       data['ultra-sun-ultra-moon'] = ultraSunUltraMoon!.toJson();
//     }
//     return data;
//   }
// }

// class GenerationViii {
//   DreamWorld? icons;

//   GenerationViii({this.icons});

//   GenerationViii.fromJson(Map<String, dynamic> json) {
//     icons = json['icons'] != null ? DreamWorld.fromJson(json['icons']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (icons != null) {
//       data['icons'] = icons!.toJson();
//     }
//     return data;
//   }
// }

// class Stats {
//   int? baseStat;
//   int? effort;
//   Ability? stat;

//   Stats({this.baseStat, this.effort, this.stat});

//   Stats.fromJson(Map<String, dynamic> json) {
//     baseStat = json['base_stat'];
//     effort = json['effort'];
//     stat = json['stat'] != null ? Ability.fromJson(json['stat']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['base_stat'] = baseStat;
//     data['effort'] = effort;
//     if (stat != null) {
//       data['stat'] = stat!.toJson();
//     }
//     return data;
//   }
// }

// class Forms {
//   String? name;
//   String? url;

//   Forms({this.name, this.url});

//   Forms.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['url'] = url;

//     return data;
//   }
// }

// class Types {
//   int? slot;
//   Ability? type;

//   Types({this.slot, this.type});

//   Types.fromJson(Map<String, dynamic> json) {
//     slot = json['slot'];
//     type = json['type'] != null ? Ability.fromJson(json['type']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['slot'] = slot;
//     if (type != null) {
//       data['type'] = type!.toJson();
//     }
//     return data;
//   }
// }
