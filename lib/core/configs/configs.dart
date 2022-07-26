class Configs {
  static const Duration maxCacheAge = Duration(hours: 1);

  static const String apiBaseUrl = 'https://api.themoviedb.org/3';

  static const String tmdbAPIKey = String.fromEnvironment('TMDB_API_KEY', defaultValue: '');
}
