import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

List<FormulaGroup> formulaGroups = [];

class FormulaBase {
  int? id;
  String name;

  int get subFormulaCount {
    return -1; //inactive
  }

  FormulaBase(this.name);
}

class FormulaGroup  extends FormulaBase {
  List<Formula> formulas = [];
  List<FormulaValue> values = [];

  @override
  int get subFormulaCount {
    return formulas.length;
  }

  FormulaGroup(String name) :super(name);

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'formulas': formulas.map((formula) => formula.toMap()).toList(),
        'values': values.map((value) => value.toMap()).toList(),
      };

  static FormulaGroup fromJson(Map<String, Object?> json) {
    var newFormulaGroup = FormulaGroup(toStringOrNull(json['name']) ?? ''); // TODO Proper default types if key is not in map
    newFormulaGroup.id = toIntOrNull(json['id']);

    var formulasRaw = toObjectWithNullableContentListOrNull(json['formulas']);
    newFormulaGroup.formulas = <Formula>[];
    if (formulasRaw != null) {
      for (var element in formulasRaw) {
        var formula = asJsonMapOrNull(element);
        if (formula == null) continue;

        newFormulaGroup.formulas.add(Formula.fromJson(formula));
      }
    }

    var valuesRaw = toObjectWithNullableContentListOrNull(json['values']);
    newFormulaGroup.values = <FormulaValue>[];
    if (valuesRaw != null) {
      for (var element in valuesRaw) {
        var value = asJsonMapOrNull(element);
        if (value == null) continue;

        newFormulaGroup.values.add(FormulaValue.fromJson(value));
      }
    }
    return newFormulaGroup;
  }


  @override
  String toString() {
    return toMap().toString();
  }
}

class Formula extends FormulaBase {
  String formula;

  Formula(this.formula) : super('');

  Map<String, Object?> toMap() {
    var map = {
      'id': id,
      'formula': formula,
    };

    if (name.isNotEmpty) map.putIfAbsent('name', () => name);

    return map;
  }

  static Formula fromJson(Map<String, Object?> json) {
    var newFormula = Formula(toStringOrNull(json['formula']) ?? ''); // TODO Proper default types if key is not in map
    newFormula.id = toIntOrNull(json['id']);
    newFormula.name = toStringOrNull(json['name']) ?? '';
    return newFormula;
  }

  static Formula fromFormula(Formula formula) {
    var newFormula = Formula(formula.formula);
    newFormula.id = formula.id;
    newFormula.name = formula.name;
    return newFormula;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

enum FormulaValueType { FIXED, INTERPOLATED, TEXT }

const _FORMULAVALUETYPE_INTERPOLATE = 'interpolate';
const _FORMULAVALUETYPE_TEXT = 'text';

FormulaValueType _readType(String? jsonType) {
  switch (jsonType) {
    case _FORMULAVALUETYPE_INTERPOLATE:
      return FormulaValueType.INTERPOLATED;
    case _FORMULAVALUETYPE_TEXT:
      return FormulaValueType.TEXT;
    default:
      return FormulaValueType.FIXED;
  }
}

class FormulaValue {
  int? id;
  String key;
  String value;
  FormulaValueType? type;

  FormulaValue(this.key, this.value, {this.type});
  
  FormulaValue.fromJson(Map<String, Object?> json)
      : id = toIntOrNull(json['id']),
        key = toStringOrNull(json['key']) ?? '',  // TODO Proper default types if key is not in map
        value = toStringOrNull(json['value']) ?? '',
        type = _readType(json['type'] as String?);

  Map<String, Object?> toMap() {
    var map = {
      'id': id,
      'key': key,
      'value': value,
    };

    String? mapType;
    switch (type) {
      case FormulaValueType.INTERPOLATED:
        mapType = _FORMULAVALUETYPE_INTERPOLATE;
        break;
      case FormulaValueType.TEXT:
        mapType = _FORMULAVALUETYPE_TEXT;
        break;
      default:
        break;
    }
    if (mapType != null) map.putIfAbsent('type', () => mapType);

    return map;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
