import 'dart:convert';

import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';

import '../generator_options.dart';
import 'icomoon_icon.dart';

class IcomoonSelection {
  final List<IcomoonIcon> icons;

  const IcomoonSelection({
    required this.icons,
  });

  factory IcomoonSelection.fromJSONString(String contents) {
    final json = jsonDecode(contents) as Map<String, dynamic>;
    final icons = json['icons'] as List<dynamic>;

    return IcomoonSelection(
      icons: icons
          .map((icon) => IcomoonIcon.fromJson(icon as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Field> makeFields(GeneratorOptions options) {
    final fields = icons.map((icon) {
      final props = icon.properties;
      final code = props.code.toRadixString(16);
      final name = ReCase(props.name).pascalCase;

      return Field((b) => b
        ..name = 'ico$name'
        ..static = true
        ..modifier = FieldModifier.constant
        ..type = refer('IconData', 'package:flutter/widgets.dart')
        ..assignment = Code('IconData(0x$code, fontFamily: _kFontFamily)'));
    }).toList();

    fields.insert(
        0,
        Field(
          (b) => b
            ..name = '_kFontFamily'
            ..static = true
            ..modifier = FieldModifier.constant
            ..assignment = Code("'${options.fontName}'"),
        ));

    return fields;
  }
}
