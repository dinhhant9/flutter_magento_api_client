/// Category model
class Category {
  final int? id;
  final int? parentId;
  final String? name;
  final bool? isActive;
  final int? position;
  final int? level;
  final String? path;
  final int? productCount;
  final List<Category>? children;
  final List<CategoryCustomAttribute>? customAttributes;
  final CategoryExtensionAttributes? extensionAttributes;

  Category({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.path,
    this.productCount,
    this.children,
    this.customAttributes,
    this.extensionAttributes,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
      isActive: json['is_active'],
      position: json['position'],
      level: json['level'],
      path: json['path'],
      productCount: json['product_count'],
      children: json['children_data'] != null
          ? (json['children_data'] as List)
              .map((c) => Category.fromJson(c))
              .toList()
          : null,
      customAttributes: json['custom_attributes'] != null
          ? (json['custom_attributes'] as List)
              .map((a) => CategoryCustomAttribute.fromJson(a))
              .toList()
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? CategoryExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (position != null) 'position': position,
      if (level != null) 'level': level,
      if (path != null) 'path': path,
      if (productCount != null) 'product_count': productCount,
      if (children != null)
        'children_data': children!.map((c) => c.toJson()).toList(),
      if (customAttributes != null)
        'custom_attributes':
            customAttributes!.map((a) => a.toJson()).toList(),
    };
  }
}

/// Custom attribute model for category
class CategoryCustomAttribute {
  final String attributeCode;
  final dynamic value;

  CategoryCustomAttribute({
    required this.attributeCode,
    this.value,
  });

  factory CategoryCustomAttribute.fromJson(Map<String, dynamic> json) {
    return CategoryCustomAttribute(
      attributeCode: json['attribute_code'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute_code': attributeCode,
      if (value != null) 'value': value,
    };
  }
}

/// Extension attributes for category
class CategoryExtensionAttributes {
  final Map<String, dynamic>? additionalAttributes;

  CategoryExtensionAttributes({
    this.additionalAttributes,
  });

  factory CategoryExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return CategoryExtensionAttributes(
      additionalAttributes: json,
    );
  }

  Map<String, dynamic> toJson() {
    return additionalAttributes ?? {};
  }
}

