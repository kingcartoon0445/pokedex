class ListPokemonModel {
  int? count;
  String? next;
  String? previous;
  List<ItemPokemonModel>? listItemPokemonModel;

  ListPokemonModel(
      {this.count, this.next, this.previous, this.listItemPokemonModel});

  ListPokemonModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      listItemPokemonModel = <ItemPokemonModel>[];
      json['results'].forEach((v) {
        listItemPokemonModel!.add(ItemPokemonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (listItemPokemonModel != null) {
      data['results'] = listItemPokemonModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPokemonModel {
  String? name;
  String? url;

  ItemPokemonModel({this.name, this.url});

  ItemPokemonModel.fromJson(Map<String, dynamic> json) {
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
