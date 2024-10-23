class UIComponent {
  final String type;
  final Map<String, dynamic> styles;
  final List<UIComponent> children;
  final String? data;

  UIComponent({
    required this.type,
    required this.styles,
    this.children = const [],
    this.data,
  });

  factory UIComponent.fromJson(Map<String, dynamic> json) {
    return UIComponent(
      type: json['type'],
      styles: Map<String, dynamic>.from(json['styles'] ?? {}),
      data: json['data'],
      children: json['children'] != null
          ? List<UIComponent>.from(
              json['children'].map((child) => UIComponent.fromJson(child)))
          : [],
    );
  }
}
