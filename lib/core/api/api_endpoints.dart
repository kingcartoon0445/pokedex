// Tập hợp các endpoint API
class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://pokeapi.co/api/v2/';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  // Lấy danh sách Pokemon với limit và offset
  static String urlListPokemon(int limit, int offset) =>
      'pokemon?limit=$limit&offset=$offset';
  static String urlListPokemonWithGeneration(String id) => 'generation/$id';
  // Lấy thông tin Pokemon với id or name
  static String urlDetailPokemon(String pokemonIdOrName) =>
      'pokemon/$pokemonIdOrName';
  static String urlDetailMove(String moveIdOrName) => 'move/$moveIdOrName';
//Cung cấp thông tin về loài như: mô tả, tỷ lệ bắt gặp, chuỗi tiến hóa, giới tính, trứng, màu sắc, v.v.
  static String urlPokemonSpecies(String idOrName) =>
      'pokemon-species/$idOrName';
  //Cung cấp thông tin đầy đủ về chuỗi tiến hóa của Pokémon
  static String urlPokemonEvolutionChain(String evolutionChainId) =>
      'evolution-chain/$evolutionChainId';
//Để lấy thông tin chi tiết về các moves
  static String urlPokemoneMoves(String idOrName) => 'move/$idOrName';
  //Để lấy thông tin chi tiết về các abilities
  static String urlPokemoneAbility(String idOrName) => 'ability/$idOrName';

  // User
  static const String userProfile = '/users/profile';
  static const String updateProfile = '/users/update-profile';

  // Các endpoint khác
  // ...
}
