class IcomoonIcon {
  final IconProperties properties;

  const IcomoonIcon({
    required this.properties,
  });

  factory IcomoonIcon.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;

    return IcomoonIcon(properties: IconProperties.fromJson(properties));
  }
}

class IconProperties {
  final String name;
  final int code;

  const IconProperties({
    required this.name,
    required this.code,
  });

  factory IconProperties.fromJson(Map<String, dynamic> json) {
    return IconProperties(
      name: json['name'] as String,
      code: json['code'] as int,
    );
  }
}
