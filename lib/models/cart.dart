/// Cart model
class MagentoCart {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final bool? isActive;
  final bool? isVirtual;
  final List<MagentoCartItem>? items;
  final int? itemsCount;
  final int? itemsQty;
  final MagentoCartCustomer? customer;
  final MagentoCartBillingAddress? billingAddress;
  final int? reservedOrderId;
  final double? subtotal;
  final double? subtotalWithDiscount;
  final double? grandTotal;
  final List<MagentoTotalSegment>? totalSegments;
  final MagentoCartExtensionAttributes? extensionAttributes;

  MagentoCart({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isVirtual,
    this.items,
    this.itemsCount,
    this.itemsQty,
    this.customer,
    this.billingAddress,
    this.reservedOrderId,
    this.subtotal,
    this.subtotalWithDiscount,
    this.grandTotal,
    this.totalSegments,
    this.extensionAttributes,
  });

  factory MagentoCart.fromJson(Map<String, dynamic> json) {
    return MagentoCart(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isActive: json['is_active'],
      isVirtual: json['is_virtual'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => MagentoCartItem.fromJson(i)).toList()
          : null,
      itemsCount: json['items_count'],
      itemsQty: json['items_qty'],
      customer: json['customer'] != null
          ? MagentoCartCustomer.fromJson(json['customer'])
          : null,
      billingAddress: json['billing_address'] != null
          ? MagentoCartBillingAddress.fromJson(json['billing_address'])
          : null,
      reservedOrderId: json['reserved_order_id'],
      subtotal: json['subtotal'] != null
          ? double.tryParse(json['subtotal'].toString())
          : null,
      subtotalWithDiscount: json['subtotal_with_discount'] != null
          ? double.tryParse(json['subtotal_with_discount'].toString())
          : null,
      grandTotal: json['grand_total'] != null
          ? double.tryParse(json['grand_total'].toString())
          : null,
      totalSegments: json['total_segments'] != null
          ? (json['total_segments'] as List)
              .map((t) => MagentoTotalSegment.fromJson(t))
              .toList()
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? MagentoCartExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (isVirtual != null) 'is_virtual': isVirtual,
      if (items != null) 'items': items!.map((i) => i.toJson()).toList(),
      if (itemsCount != null) 'items_count': itemsCount,
      if (itemsQty != null) 'items_qty': itemsQty,
      if (customer != null) 'customer': customer!.toJson(),
      if (billingAddress != null)
        'billing_address': billingAddress!.toJson(),
      if (reservedOrderId != null) 'reserved_order_id': reservedOrderId,
      if (subtotal != null) 'subtotal': subtotal,
      if (subtotalWithDiscount != null)
        'subtotal_with_discount': subtotalWithDiscount,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (totalSegments != null)
        'total_segments': totalSegments!.map((t) => t.toJson()).toList(),
    };
  }
}

/// Cart item model
class MagentoCartItem {
  final int? itemId;
  final String? sku;
  final int? qty;
  final String? name;
  final double? price;
  final String? productType;
  final MagentoCartProduct? productOption;
  final MagentoCartExtensionAttributes? extensionAttributes;

  MagentoCartItem({
    this.itemId,
    this.sku,
    this.qty,
    this.name,
    this.price,
    this.productType,
    this.productOption,
    this.extensionAttributes,
  });

  factory MagentoCartItem.fromJson(Map<String, dynamic> json) {
    return MagentoCartItem(
      itemId: json['item_id'],
      sku: json['sku'],
      qty: json['qty'] != null ? int.tryParse(json['qty'].toString()) : null,
      name: json['name'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      productType: json['product_type'],
      productOption: json['product_option'] != null
          ? MagentoCartProduct.fromJson(json['product_option'])
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? MagentoCartExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (itemId != null) 'item_id': itemId,
      if (sku != null) 'sku': sku,
      if (qty != null) 'qty': qty,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (productType != null) 'product_type': productType,
      if (productOption != null) 'product_option': productOption!.toJson(),
    };
  }
}

/// Billing address for cart
class MagentoCartBillingAddress {
  final int? id;
  final String? region;
  final String? regionId;
  final String? regionCode;
  final String? countryId;
  final List<String>? street;
  final String? telephone;
  final String? postcode;
  final String? city;
  final String? firstName;
  final String? lastName;
  final String? email;

  MagentoCartBillingAddress({
    this.id,
    this.region,
    this.regionId,
    this.regionCode,
    this.countryId,
    this.street,
    this.telephone,
    this.postcode,
    this.city,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory MagentoCartBillingAddress.fromJson(Map<String, dynamic> json) {
    return MagentoCartBillingAddress(
      id: json['id'],
      region: json['region'],
      regionId: json['region_id']?.toString(),
      regionCode: json['region_code'],
      countryId: json['country_id'],
      street: json['street'] != null
          ? List<String>.from(json['street'])
          : null,
      telephone: json['telephone'],
      postcode: json['postcode'],
      city: json['city'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (region != null) 'region': region,
      if (regionId != null) 'region_id': regionId,
      if (regionCode != null) 'region_code': regionCode,
      if (countryId != null) 'country_id': countryId,
      if (street != null) 'street': street,
      if (telephone != null) 'telephone': telephone,
      if (postcode != null) 'postcode': postcode,
      if (city != null) 'city': city,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
      if (email != null) 'email': email,
    };
  }
}

/// Total segment model
class MagentoTotalSegment {
  final String? code;
  final String? title;
  final double? value;
  final String? area;
  final MagentoCartExtensionAttributes? extensionAttributes;

  MagentoTotalSegment({
    this.code,
    this.title,
    this.value,
    this.area,
    this.extensionAttributes,
  });

  factory MagentoTotalSegment.fromJson(Map<String, dynamic> json) {
    return MagentoTotalSegment(
      code: json['code'],
      title: json['title'],
      value: json['value'] != null
          ? double.tryParse(json['value'].toString())
          : null,
      area: json['area'],
      extensionAttributes: json['extension_attributes'] != null
          ? MagentoCartExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (area != null) 'area': area,
    };
  }
}

/// Extension attributes for cart
class MagentoCartExtensionAttributes {
  final Map<String, dynamic>? additionalAttributes;

  MagentoCartExtensionAttributes({
    this.additionalAttributes,
  });

  factory MagentoCartExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return MagentoCartExtensionAttributes(
      additionalAttributes: json,
    );
  }

  Map<String, dynamic> toJson() {
    return additionalAttributes ?? {};
  }
}

/// Customer model (simplified for cart)
class MagentoCartCustomer {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;

  MagentoCartCustomer({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory MagentoCartCustomer.fromJson(Map<String, dynamic> json) {
    return MagentoCartCustomer(
      id: json['id'],
      email: json['email'],
      firstName: json['firstname'],
      lastName: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
    };
  }
}

/// Product model (simplified for cart)
class MagentoCartProduct {
  final String? sku;
  final String? name;

  MagentoCartProduct({
    this.sku,
    this.name,
  });

  factory MagentoCartProduct.fromJson(Map<String, dynamic> json) {
    return MagentoCartProduct(
      sku: json['sku'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
    };
  }
}

