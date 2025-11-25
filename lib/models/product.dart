/// Product model
class Product {
  final String? sku;
  final String? name;
  final String? typeId;
  final double? price;
  final String? status;
  final int? visibility;
  final String? image;
  final List<String>? images;
  final String? description;
  final String? shortDescription;
  final List<CustomAttribute>? customAttributes;
  final List<MediaGalleryEntry>? mediaGalleryEntries;
  final ProductExtensionAttributes? extensionAttributes;

  Product({
    this.sku,
    this.name,
    this.typeId,
    this.price,
    this.status,
    this.visibility,
    this.image,
    this.images,
    this.description,
    this.shortDescription,
    this.customAttributes,
    this.mediaGalleryEntries,
    this.extensionAttributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sku: json['sku'],
      name: json['name'],
      typeId: json['type_id'],
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      status: json['status']?.toString(),
      visibility: json['visibility'],
      image: json['custom_attributes'] != null
          ? _getCustomAttributeValue(json['custom_attributes'], 'image')
          : null,
      images: json['media_gallery_entries'] != null
          ? (json['media_gallery_entries'] as List)
              .map((e) => e['file'] as String)
              .toList()
          : null,
      description: json['custom_attributes'] != null
          ? _getCustomAttributeValue(json['custom_attributes'], 'description')
          : null,
      shortDescription: json['custom_attributes'] != null
          ? _getCustomAttributeValue(json['custom_attributes'], 'short_description')
          : null,
      customAttributes: json['custom_attributes'] != null
          ? (json['custom_attributes'] as List)
              .map((a) => CustomAttribute.fromJson(a))
              .toList()
          : null,
      mediaGalleryEntries: json['media_gallery_entries'] != null
          ? (json['media_gallery_entries'] as List)
              .map((e) => MediaGalleryEntry.fromJson(e))
              .toList()
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? ProductExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  static String? _getCustomAttributeValue(
      List<dynamic> attributes, String code) {
    try {
      final attr = attributes.firstWhere(
        (a) => a['attribute_code'] == code,
        orElse: () => null,
      );
      return attr?['value']?.toString();
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (typeId != null) 'type_id': typeId,
      if (price != null) 'price': price,
      if (status != null) 'status': status,
      if (visibility != null) 'visibility': visibility,
      if (customAttributes != null)
        'custom_attributes':
            customAttributes!.map((a) => a.toJson()).toList(),
      if (mediaGalleryEntries != null)
        'media_gallery_entries':
            mediaGalleryEntries!.map((e) => e.toJson()).toList(),
    };
  }
}

/// Custom attribute model
class CustomAttribute {
  final String attributeCode;
  final dynamic value;

  CustomAttribute({
    required this.attributeCode,
    this.value,
  });

  factory CustomAttribute.fromJson(Map<String, dynamic> json) {
    return CustomAttribute(
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

/// Media gallery entry model
class MediaGalleryEntry {
  final int? id;
  final String? mediaType;
  final String? label;
  final int? position;
  final bool? disabled;
  final List<String>? types;
  final String? file;

  MediaGalleryEntry({
    this.id,
    this.mediaType,
    this.label,
    this.position,
    this.disabled,
    this.types,
    this.file,
  });

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) {
    return MediaGalleryEntry(
      id: json['id'],
      mediaType: json['media_type'],
      label: json['label'],
      position: json['position'],
      disabled: json['disabled'],
      types: json['types'] != null ? List<String>.from(json['types']) : null,
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (mediaType != null) 'media_type': mediaType,
      if (label != null) 'label': label,
      if (position != null) 'position': position,
      if (disabled != null) 'disabled': disabled,
      if (types != null) 'types': types,
      if (file != null) 'file': file,
    };
  }
}

/// Extension attributes for product
class ProductExtensionAttributes {
  final Map<String, dynamic>? additionalAttributes;

  ProductExtensionAttributes({
    this.additionalAttributes,
  });

  factory ProductExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return ProductExtensionAttributes(
      additionalAttributes: json,
    );
  }

  Map<String, dynamic> toJson() {
    return additionalAttributes ?? {};
  }
}

