import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/games/sudoku/logic/sudoku_solver.dart';

void main() {
  group("Sudoku.solve:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : [[4, 5, 0, 0, 0, 0, 0, 6, 0], [0, 0, 7, 9, 4, 0, 0, 0, 0], [0, 8, 0, 0, 0, 1, 0, 0, 7], [0, 0, 1, 0, 0, 0, 0, 0, 5], [0, 0, 8, 7, 0, 0, 4, 0, 0], [0, 6, 9, 4, 3, 0, 0, 0, 1], [0, 1, 0, 5, 6, 0, 0, 7, 2], [2, 0, 0, 1, 0, 0, 0, 0, 3], [0, 0, 0, 3, 0, 2, 0, 0, 0]],
        'expectedOutput' : [[4, 5, 2, 8, 7, 3, 1, 6, 9], [1, 3, 7, 9, 4, 6, 5, 2, 8], [9, 8, 6, 2, 5, 1, 3, 4, 7], [3, 4, 1, 6, 2, 8, 7, 9, 5], [5, 2, 8, 7, 1, 9, 4, 3, 6], [7, 6, 9, 4, 3, 5, 2, 8, 1], [8, 1, 3, 5, 6, 4, 9, 7, 2], [2, 9, 4, 1, 8, 7, 6, 5, 3], [6, 7, 5, 3, 9, 2, 8, 1, 4]],
        'solutionCount': 1
      },
      {'input' : [[0, 0, 0, 0, 2, 4, 3, 0, 7], [9, 0, 0, 0, 6, 0, 0, 0, 0], [7, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 5, 0, 0, 7, 9, 4], [0, 6, 5, 0, 0, 0, 0, 0, 0], [0, 0, 0, 8, 0, 3, 0, 0, 0], [0, 5, 4, 0, 0, 0, 0, 6, 0], [0, 0, 0, 0, 0, 0, 0, 5, 9], [0, 0, 3, 4, 0, 8, 0, 0, 0]],
        'expectedOutput' : [[5, 8, 6, 9, 2, 4, 3, 1, 7], [9, 4, 1, 3, 6, 7, 5, 8, 2], [7, 3, 2, 1, 8, 5, 9, 4, 6], [3, 2, 8, 5, 1, 6, 7, 9, 4], [4, 6, 5, 2, 7, 9, 1, 3, 8], [1, 7, 9, 8, 4, 3, 6, 2, 5], [2, 5, 4, 7, 9, 1, 8, 6, 3], [8, 1, 7, 6, 3, 2, 4, 5, 9], [6, 9, 3, 4, 5, 8, 2, 7, 1]],
        'solutionCount': 1
      },
      {'input' : [[0, 0, 0, 0, 0, 4, 3, 0, 7], [9, 0, 0, 0, 6, 0, 0, 0, 0], [7, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 5, 0, 0, 7, 9, 4], [0, 6, 5, 0, 0, 0, 0, 0, 0], [0, 0, 0, 8, 0, 3, 0, 0, 0], [0, 5, 4, 0, 0, 0, 0, 6, 0], [0, 0, 0, 0, 0, 0, 0, 5, 9], [0, 0, 3, 4, 0, 8, 0, 0, 0]],
        'expectedOutput' : [[5, 1, 6, 2, 9, 4, 3, 8, 7], [9, 3, 8, 1, 6, 7, 5, 4, 2], [7, 4, 2, 3, 8, 5, 9, 1, 6], [3, 8, 1, 5, 2, 6, 7, 9, 4], [2, 6, 5, 7, 4, 9, 1, 3, 8], [4, 7, 9, 8, 1, 3, 6, 2, 5], [1, 5, 4, 9, 7, 2, 8, 6, 3], [8, 2, 7, 6, 3, 1, 4, 5, 9], [6, 9, 3, 4, 5, 8, 2, 7, 1]],
        'solutionCount': 10
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {

        var _actual = SudokuBoard(board: elem['input'] as List<List<int>>);
        _actual.solveSudoku(10);
        expect(_actual.solutions?[0].solution, elem['expectedOutput']);
        expect(_actual.solutions?.length, elem['solutionCount']);
      });
    }
  });
}