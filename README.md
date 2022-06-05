# dart_icons_generator

[![pub](https://img.shields.io/pub/v/dart_icons_generator.svg?style=flat)](https://pub.dev/packages/dart_icons_generator)

This plugin is a icons generator plugin.

## Features

- icomoon

## Setup

Place the following `selection.json`, `icomoon.ttf` files in the folder.

```bash
assets/icomoon
```

Set the following in `pubspec.yaml`

```yaml
dev_dependencies:
  ...
  build_runner: ^2.1.11
  dart_icons_generator: latest

flutter:
  uses-material-design: true
  ...
  fonts:
    - family: Icomoon
      fonts:
        - asset: assets/icomoon/icomoon.ttf
```

Create or Configure your `build.yaml` in project

```yaml
targets:
  $default:
    builders:
      dart_icons_generator|icomoon:
        generate_for:
          include:
            - assets/icomoon/selection.json
        options:
          font_name: Icomoon
```

Run code generation

```bash
flutter pub run build_runner build
```

## Using

```dart
const Icon(Icomoon.icoHome)
```