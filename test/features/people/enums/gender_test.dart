import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/enums/gender.dart';

void main() {
  test('Female gender is equivalent to 1', () {
    expect(Gender.female.toInt, equals(1));

    expect(Gender.fromInt(1), Gender.female);
  });

  test('Male gender is equivalent to 2', () {
    expect(Gender.male.toInt, equals(2));

    expect(Gender.fromInt(2), Gender.male);
  });
}
