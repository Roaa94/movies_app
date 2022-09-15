/// Enum to indicated male, female, or unknown person gender
enum Gender {
  /// Female gender value
  female,

  /// Male gender value
  male,

  /// Unknown gender value
  unknown;

  /// Integer value from gender value based on the TMDB response
  int get toInt {
    switch (this) {
      case Gender.unknown:
        return 0;
      case Gender.female:
        return 1;
      case Gender.male:
        return 2;
    }
  }

  /// Gender value from integer value based on the TMDB response
  static Gender fromInt(int integer) {
    switch (integer) {
      case 1:
        return Gender.female;
      case 2:
        return Gender.male;
      default:
        return Gender.unknown;
    }
  }
}
