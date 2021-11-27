List<FormulaGroup> formulaGroups = [];

class FormulaGroup {
  int id;
  String name;
  List<Formula> formulas = [];
  List<FormulaValue> values = [];

  FormulaGroup(this.name);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'formulas': formulas.map((formula) => formula.toMap()).toList(),
        'values': values.map((value) => value.toMap()).toList(),
      };

  FormulaGroup.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        formulas = List<Formula>.from(json['formulas'].map((formula) => Formula.fromJson(formula))),
        values = List<FormulaValue>.from(json['values'].map((value) => FormulaValue.fromJson(value)));

  @override
  String toString() {
    return toMap().toString();
  }
}

class Formula {
  int id;
  String formula;

  Formula(this.formula);

  Map<String, dynamic> toMap() => {
        'id': id,
        'formula': formula,
      };

  Formula.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        formula = json['formula'];

  static Formula fromFormula(Formula formula) {
    var newFormula = Formula(formula.formula);
    newFormula.id = formula.id;
    return newFormula;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

enum FormulaValueType {VALUE, RANGE}

class FormulaValue {
  int id;
  String key;
  String value;
  FormulaValueType type;

  FormulaValue(this.key, this.value, {this.type});

  FormulaValue.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        value = json['value'],
        type = json['type'] == 'interpolate' ? FormulaValueType.RANGE : FormulaValueType.VALUE;

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'key': key,
      'value': value,
    };

    if (type == FormulaValueType.RANGE)
      map.putIfAbsent('type', () => 'interpolate');

    return map;
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
