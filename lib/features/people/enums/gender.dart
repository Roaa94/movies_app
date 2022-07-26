enum Gender {
  female,
  male,
  unknown;

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
