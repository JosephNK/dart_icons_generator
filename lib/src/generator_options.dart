import 'package:build/build.dart';

class GeneratorOptions {
  final String fontName;

  const GeneratorOptions({
    required this.fontName,
  });

  factory GeneratorOptions.fromOptions(BuilderOptions options) {
    final config = options.config;

    final fontName = config['font_name'];

    assert(
      fontName != null,
      'fontName must not be null',
    );

    return GeneratorOptions(
      fontName: fontName as String,
    );
  }
}
