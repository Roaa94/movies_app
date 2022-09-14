/// App level configuration variables
class Configs {
  /// The max allowed age duration for the http cache
  static const Duration maxCacheAge = Duration(hours: 1);

  /// Base API URL of The TMDB API
  ///
  /// See: https://developers.themoviedb.org/3/getting-started/introduction
  static const String apiBaseUrl = 'https://api.themoviedb.org/3';

  /// API Key registered with The TMDB API
  ///
  /// See: https://developers.themoviedb.org/3/getting-started/introduction
  static const String tmdbAPIKey = String.fromEnvironment('TMDB_API_KEY');
}
