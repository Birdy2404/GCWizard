part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

class _GCWList {
  late List<Object> _contents;

  _GCWList() {
    _contents = <Object>[];
  }

  int length() {
    return _contents.length;
  }

  void add(Object? value ) {
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

  void sort(){
    _contents.sort();
  }

  void insert(int index, Object? value){
    if (value != null) _contents.insert(index, value);
  }

  void remove(int index,){
    _contents.remove(index);
  }

  void reverse(){
    _contents.reversed.toList();
  }

  String toString(){
    return _contents.toString();
  }

  Object getIndex(int index){
    if (_contents.isEmpty) return 'NIL';
    if (index > _contents.length -1) return 'NIL';
    return _contents[index];
  }

}



void _listClear(_GCWList? list) {
   if (list != null) {
     list.clear();
   }
}

void _listAdd(_GCWList? list, Object? value){
  if (list != null) {
    if (_isNotList(list)) {
      _handleError(_INVALIDTYPECAST);
    }
    if (value != null) {
      list.add(value);
    }
  }
}

void _listSort(_GCWList? list, int mode){
  if (list != null) {
    list.sort();
    if (mode == 0) {
      list.reverse();
    }
  }
}

void _listShuffle(_GCWList? list){
  if (list != null) {
    list.shuffle();
  }
}

String _listToString(_GCWList? list){
  if (list == null) {
    return '';
  } else {
    return list.toString();
  }
}

void _listAddAll(_GCWList? listto, _GCWList? listfrom){
  if (listto != null) {
    listto.addall(listfrom);
  }
}

void _listInsert(_GCWList? list, int index, Object? value){
  if (list != null) {
    list.insert(index, value);
  }
}

void _listRemove(_GCWList? list, int index){
  if (list != null) {
    list.remove(index);
  }
}

int _listLength(_GCWList? list){
  if (list == null) {
    return 0;
  } else {
    return list.length();
  }
}

bool _listIsEmpty(_GCWList? list){
  return (_listLength(list) == 0);
}

bool _listIsNotEmpty(_GCWList? list){
  return (_listLength(list) != 0);
}

Object? _listGet(_GCWList? list, int index){
  if (list == null) {
    return 'NIL';
  } else {
    return list.getIndex(index);
  }
}
