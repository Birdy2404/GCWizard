part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

class _GCWList {
  late List<Object> _contents;

  _GCWList() {
    _contents = <Object>[];
  }

  int length() {
    return _contents.length;
  }

  void add(Object? value) {
    if (value != null) _contents.add(value);
  }

  void addall(_GCWList? list) {
    if (list != null) _contents.addAll(list._contents);
  }

  void clear() {
    _contents = [];
  }

  void shuffle() {
    _contents.shuffle();
  }

  @override
  void sort() {
    //https://stackoverflow.com/questions/67847956/can-i-sort-listdynamic-in-dart
    _contents.sort(
      (a, b) {
        if ((a is num && b is num)) {
          return a.compareTo(b);
        }
        if (a is String && b is String) {
          return a.compareTo(b);
        }
        if (a is _GCWList && b is _GCWList) {
          return a.length().compareTo(b.length());
        }

        if (a is num && b is String) {
          return -1;
        } else if (a is num && b is _GCWList) {
          return -1;
        } else if (a is String && b is _GCWList) {
          return -1;
        } else if (a is _GCWList && b is num) {
          return 1;
        } else if (a is _GCWList && b is String) {
          return 1;
        } else if (a is String && b is num) {
          return 1;
        }
        return 0;
      },
    );
  }

  void insert(int index, Object? value) {
    if (value != null) _contents.insert(index, value);
  }

  void remove(
    int index,
  ) {
    _contents.remove(index);
  }

  void reverse() {
    //https://stackoverflow.com/questions/67847956/can-i-sort-listdynamic-in-dart
    _contents.sort(
      (a, b) {
        if ((a is num && b is num)) {
          return a.compareTo(b);
        }
        if (a is String && b is String) {
          return a.compareTo(b);
        }
        if (a is _GCWList && b is _GCWList) {
          return a.length().compareTo(b.length());
        }

        if (a is num && b is String) {
          return 1;
        } else if (a is num && b is _GCWList) {
          return 1;
        } else if (a is String && b is _GCWList) {
          return 1;
        } else if (a is _GCWList && b is num) {
          return -1;
        } else if (a is _GCWList && b is String) {
          return -1;
        } else if (a is String && b is num) {
          return -1;
        }
        return 0;
      },
    );
  }

  @override
  String toString() {
    return _contents.toString();
  }

  Object getIndex(int index) {
    if (_contents.isEmpty) return 'NIL';
    if (index > _contents.length - 1) return 'NIL';
    return _contents[index];
  }

  List<Object> getContent() {
    return _contents;
  }
}

void _listClear(_GCWList? list) {
  if (list != null) {
    list.clear();
  }
}

void _listAdd(_GCWList? list, Object? value) {
  if (list != null) {
    if (value != null) {
      list.add(value);
    }
  }
}

void _listSort(_GCWList? list, Object? mode) {
  if (list != null) {
    if (_isNotAInt(mode)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      switch (mode as int) {
        case 0:
          list.reverse();
          break;
        case 1:
          list.sort();
          break;
      }
    }
  }
}

void _listShuffle(_GCWList? list) {
  if (list != null) {
    list.shuffle();
  }
}

String _listToString(_GCWList? list) {
  if (list == null) {
    return '';
  } else {
    return list.toString();
  }
}

void _listAddAll(_GCWList? listto, _GCWList? listfrom) {
  if (listto != null) {
    listto.addall(listfrom);
  }
}

void _listInsert(_GCWList? list, Object? index, Object? value) {
  if (list != null) {
    if (_isNotAInt(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (index as int >= list.length()) {
        _handleError(_RANGEERROR);
      } else {
        list.insert(index, value);
      }
    }
  }
}

void _listRemove(_GCWList? list, Object? index) {
  if (list != null) {
    if (_isNotAInt(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (index as int >= list.length()) {
        _handleError(_RANGEERROR);
      } else {
        list.remove(index);
      }
    }
  }
}

int _listLength(_GCWList? list) {
  if (list == null) {
    return 0;
  } else {
    return list.length();
  }
}

int _listIsEmpty(_GCWList? list) {
  if (_listLength(list) == 0) return 1;
  return 0;
}

int _listIsNotEmpty(_GCWList? list) {
  if (_listLength(list) == 0) return 0;
  return 1;
}

Object? _listGet(_GCWList? list, Object? index) {
  if (list != null) {
    if (_isNotAInt(index)) {
      _handleError(_INVALIDTYPECAST);
    } else {
      if (index as int >= list.length()) {
        _handleError(_RANGEERROR);
      } else {
        return list.getIndex(index);
      }
    }
  }
}
