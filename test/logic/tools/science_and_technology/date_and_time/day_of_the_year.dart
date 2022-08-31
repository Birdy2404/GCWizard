import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/day_of_the_year.dart';

void main() {
  group("DayOfTheYear.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'year' : null, 'day': null, 'expectedOutput' : null},

      {'year' : 2022, 'day': 243, 'expectedOutput' : DayOfTheYearOutput(DateTime(2022,8,31),  3, 35)},
      {'year' : 2020, 'day': 1,   'expectedOutput' : DayOfTheYearOutput(DateTime(2020, 1, 1), 3, 1)},
      {'year' : 2021, 'day': 1,   'expectedOutput' : DayOfTheYearOutput(DateTime(2021, 1, 1), 5, 53)},
      {'year' : 2022, 'day': 1,   'expectedOutput' : DayOfTheYearOutput(DateTime(2022, 1, 1), 6, 52)},

      {'year' : 2020, 'day': 366, 'expectedOutput' : DayOfTheYearOutput(DateTime(2020, 12, 31), 4, 53)},
      {'year' : 2021, 'day': 365, 'expectedOutput' : DayOfTheYearOutput(DateTime(2021, 12, 31), 5, 52)},
      {'year' : 2022, 'day': 365, 'expectedOutput' : DayOfTheYearOutput(DateTime(2022, 12, 31), 6, 52)},

      {'year' : 2020, 'day': 367, 'expectedOutput' : DayOfTheYearOutput(DateTime(2021, 1, 1),  5, 53)},
      {'year' : 2022, 'day': 0,   'expectedOutput' : DayOfTheYearOutput(DateTime(2021, 12, 31), 5, 52)},
    ];

    _inputsToExpected.forEach((elem) {
      test('year: ${elem['year']}, day: ${elem['day']}', () {
        DayOfTheYearOutput _actual = decode(elem['year'], elem['day']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else {
          expect(_actual.date, elem['expectedOutput'].date);
          expect(_actual.weekday, elem['expectedOutput'].weekday);
          expect(_actual.weeknumber, elem['expectedOutput'].weeknumber);
        }
      });
    });
  });

  group("DayOfTheYear.isoWeekOfYear:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},

      {'input' : DateTime(2020, 1, 1), 'expectedOutput' : 1},
      {'input' : DateTime(2021, 1, 1), 'expectedOutput' : 53},
      {'input' : DateTime(2022, 1, 1), 'expectedOutput' : 52},
      {'input' : DateTime(2020, 12, 31), 'expectedOutput' : 53},
      {'input' : DateTime(2021, 12, 31), 'expectedOutput' : 52},
      {'input' : DateTime(2022, 12, 31), 'expectedOutput' : 52},

      {'input' : DateTime(2022, 1, 3), 'expectedOutput' : 1},
      {'input' : DateTime(2018, 1, 7), 'expectedOutput' : 1},
      {'input' : DateTime(2018, 1, 8), 'expectedOutput' : 2},

      {'input' : DateTime(2022, 8, 31), 'expectedOutput' : 35},

      {'input' : DateTime(2020, 2, 29), 'expectedOutput' : 9},
      {'input' : DateTime(2021, 2, 29), 'expectedOutput' : 9},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = isoWeekOfYear(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}