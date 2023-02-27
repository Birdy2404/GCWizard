import 'dart:math';

import 'package:gc_wizard/tools/games/sudoku/logic/dartist_sudoku_solver/logic/sudoku.dart';

enum SudokuFillType { USER_FILLED, CALCULATED }

class SudokuBoardValue {
  SudokuFillType type;
  int? value;

  SudokuBoardValue(this.value, this.type);
}

class SudokuBoard {
  late List<List<SudokuBoardValue?>> board;
  List<_SudokuSolution>? solutions;

  SudokuBoard({List<List<int>>? board}) {
    this.board = List<List<SudokuBoardValue?>>.generate(
        9, (index) => List<SudokuBoardValue?>.generate(9, (index) => null));

    if (board != null) {
      for (int i = 0; i < min(board.length, this.board.length); i++ ) {
        for (int j = 0; j < min(board[i].length, this.board[i].length); j++ ) {
          if (board[i][j] > 0 && board[i][j] <= 9)
            setValue(i, j, board[i][j]);
        }
      }
    }
  }

  void setValue (int i, int j, int? value, {SudokuFillType type = SudokuFillType.USER_FILLED}) {
    board[i][j] = SudokuBoardValue(value, type);
  }

  int? getValue (int i, int j) {
    return board[i][j]?.value;
  }

  SudokuFillType getFillType(int i, int j) {
    return (board[i][j] == null || board[i][j]!.type == SudokuFillType.CALCULATED)
        ? SudokuFillType.CALCULATED
        : SudokuFillType.USER_FILLED;
  }

  void solveSudoku(int maxSolutions) {
    var solutions = solve(_solveableBoard(), maxSolutions: maxSolutions);
    if (solutions == null) return null;

    this.solutions = solutions.map((solution) => _SudokuSolution(solution)).toList();
  }

  List<List<int>> _solveableBoard() {
    return board.map((column) {
      return column
          .map((row) => row != null && row.type == SudokuFillType.USER_FILLED
          ? (row.value is int) ? row.value as int : 0
          : 0)
          .toList();
    }).toList();
  }
}

class _SudokuSolution {
  List<List<int?>> _solution;

  _SudokuSolution(List<List<int?>> this._solution);

  int? getValue (int i, int j) {
    return _solution[i][j];
  }
}



