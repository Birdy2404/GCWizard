import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

List<MultiDecoderToolEntity> multiDecoderTools = [];

MultiDecoderToolEntity findMultiDecoderToolById(int id) {
  return multiDecoderTools.firstWhere((tool) => tool.id == id);
}

class MultiDecoderToolEntity {
  late int id;
  late String name;
  late String internalToolName;
  late List<MultiDecoderToolOption> options;

  MultiDecoderToolEntity(this.name, this.internalToolName, {this.options = const []});

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'decoderFunctionName': internalToolName,
        'options': options.map((option) => option.toMap()).toList()
      };

  MultiDecoderToolEntity.fromJson(Map<String, Object?> json) {
    this.id = toIntOrNull(json['id']) ?? -1;
    this.name = toStringOrNull(json['name']) ?? '';  // TODO Proper default types if key is not in map
    this.internalToolName = toStringOrNull(json['decoderFunctionName']) ?? '';  // TODO Proper default types if key is not in map

    var optionsRaw = toObjectWithNullableContentListOrNull(json['options']);
    this.options = <MultiDecoderToolOption>[];
    if (optionsRaw != null) {
      optionsRaw.forEach((Object? element) {
        var option = asJsonMapOrNull(element);
        if (option == null) return;

        this.options.add(MultiDecoderToolOption.fromJson(option));
      });
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class MultiDecoderToolOption {
  String name;
  Object? value;

  MultiDecoderToolOption(this.name, this.value);

  Map<String, Object?> toMap() => {'name': name, 'value': value};

  MultiDecoderToolOption.fromJson(Map<String, Object?> json)
      : name = toStringOrNull(json['name']) ?? '',  // TODO Proper default types if key is not in map
        value = json['value'];

  @override
  String toString() {
    return toMap().toString();
  }
}
