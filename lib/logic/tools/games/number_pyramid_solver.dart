import 'dart:math';

import 'package:gc_wizard/logic/tools/games/dennistreysa_number_pyramid_solver/pyramid.dart';

enum NumberPyramidFillType { USER_FILLED, CALCULATED }

List<List<List<int>>> solvePyramid(List<List<int>> pyramid, int maxSolutions) {
	return solve(pyramid, maxSolutions: maxSolutions);
}

class NumberPyramid {
	List<List<Map<String, dynamic>>> pyramid;
	var columnCount;
	var rowCount;

	NumberPyramid(int rowCount, {NumberPyramid oldPyramid}) {
		this.rowCount = rowCount;
		pyramid = List<List<Map<String, dynamic>>>.generate(
				rowCount, (index) => List<Map<String, dynamic>>.generate(index+1, (index) => null));

		if (oldPyramid != null) {
			for (var layer=0; layer < min(oldPyramid.rowCount, rowCount); layer++) {
				for (var brick=0; brick < pyramid[layer].length; brick++) {
					if (oldPyramid.pyramid[layer][brick] != null)
						pyramid[layer][brick]= oldPyramid.pyramid[layer][brick];
				}
			}
		}
	}

	int getRowsCount() {
		return rowCount;
	}

	int getColumnsCount(int row) {
		return row + 1;
	}

	int getValue(int x, int y) {
		if (!_validPosition(x, y) || pyramid[y][x] == null)
			return null;
		return pyramid[y][x]['value'];
	}

	// return value changed
	bool setValue(int x, int y, int value, NumberPyramidFillType type) {
		int oldValue;
		bool valueChanged = false;
		if (!_validPosition(x, y)) return false;

		oldValue = getValue(x, y);
		if (value != oldValue)
			valueChanged = true;

		pyramid[y][x] = {'value': value, 'type': type};

		return valueChanged;
	}

	NumberPyramidFillType getType(int x, int y) {
		if (!_validPosition(x, y)) return null;

		if (pyramid[y][x] != null)
			return pyramid[y][x]['type'];

		return null;
	}

	bool _validPosition(int x, int y) {
		return !(pyramid == null || y >= pyramid.length || pyramid[y] == null || x >= pyramid[y].length);
	}



	List<List<int>> solveableBoard() {
		var board = <List<int>>[];
		for (var y = 0; y < pyramid.length; y++) {
			var row = <int>[];
			for (var x = 0; x < pyramid[y].length; x++) {
				row.add(getType(x, y) == NumberPyramidFillType.USER_FILLED ? getValue(x, y) : null);
			}
			board.add(row);
		}
		return board;
	}

	removeCalculated() {
		for (var y = 0; y < pyramid.length; y++) {
			for (var x = 0; x < pyramid[y].length; x++) {
				if (getType(x, y) == NumberPyramidFillType.CALCULATED) setValue(x, y, null, NumberPyramidFillType.CALCULATED);
			}
		}
	}

	// String toJson() {
	// 	var list = <String>[];
	// 	for(var y = 0; y < matrix.length; y++) {
	// 		for (var x = 0; x < matrix[y].length; x++) {
	// 			if ( matrix[y][x] != null || !matrix[y][x].isEmpty)
	// 				list.add(jsonEncode({'x': x, 'y': y, 'value': matrix[y][x]}));
	// 		}
	// 	}
	//
	// 	var json = jsonEncode({'columns': columnCount, 'rows': rowCount, 'values': jsonEncode(list)});
	//
	// 	return json;
	// }


	// static SymbolMatrix fromJson(String text) {
	// 	if (text == null) return null;
	// 	var json = jsonDecode(text);
	// 	if (json == null) return null;
	//
	// 	SymbolMatrix matrix;
	// 	var rowCount = jsonDecode(json)['rows'];
	// 	var columnCount = jsonDecode(json)['columns'];
	// 	var values = jsonDecode(json)['values'];
	// 	if (rowCount == null || columnCount == null) return null;
	//
	// 	matrix = SymbolMatrix(rowCount, columnCount);
	// 	if (values != null) {
	// 		for (var jsonElement in values) {
	// 			var element = jsonDecode(jsonElement);
	// 			var x = element['x'];
	// 			var y = element['y'];
	// 			var value = element['value'];
	// 			if (x != null && y != null && value != null)
	// 				matrix.setValue(y, x, value);
	// 		}
	// 	}
	// 	return matrix;
	// }
}