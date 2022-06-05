import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_icons_generator/src/generator_options.dart';
import 'package:dart_style/dart_style.dart';

import 'src/icomoon/icomoon_selection.dart';

Builder sourceGenFromOptions(BuilderOptions options) {
  final parsedOptions = GeneratorOptions.fromOptions(options);
  return IcomoonBuilder(parsedOptions);
}

///////////////////////////////////////////////////////////////////////////////

class IcomoonBuilder implements Builder {
  final GeneratorOptions options;

  const IcomoonBuilder(this.options);

  @override
  Map<String, List<String>> get buildExtensions => {
        '.json': ['.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    print('inputId: $inputId');

    final jsonString = await buildStep.readAsString(inputId);

    final icomoonClass = Class((b) => b
      ..name = options.fontName
      ..constructors.add(
        Constructor((b) => b..name = '_'),
      )
      ..fields.addAll(
        IcomoonSelection.fromJSONString(jsonString).makeFields(options),
      ));

    final StringSink content = Library(
      (b) => b.body..add(icomoonClass),
    ).accept(
      DartEmitter(allocator: Allocator()),
    );

    await write(buildStep, content, options);
  }

  Future<void> write(
    BuildStep buildStep,
    StringSink content,
    GeneratorOptions options,
  ) async {
    final inputId = buildStep.inputId;

    final AssetId writeId = inputId.changeExtension('.dart');

    final String writeContent = DartFormatter().format('''
        // Generated, by icons_generator do not modify by hand
        
        // ignore_for_file: constant_identifier_names
        $content
      ''');

    await buildStep.writeAsString(writeId, writeContent);
  }
}
