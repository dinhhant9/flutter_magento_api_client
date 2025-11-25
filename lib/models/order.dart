/// Order model
class Order {
  final int? entityId;
  final String? incrementId;
  final String? status;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? customerEmail;
  final int? customerId;
  final String? customerFirstName;
  final String? customerLastName;
  final double? baseGrandTotal;
  final double? grandTotal;
  final String? baseCurrencyCode;
  final String? orderCurrencyCode;
  final List<OrderItem>? items;
  final OrderBillingAddress? billingAddress;
  final ShippingAddress? shippingAddress;
  final Payment? payment;
  final Shipping? shipping;
  final OrderExtensionAttributes? extensionAttributes;

  Order({
    this.entityId,
    this.incrementId,
    this.status,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.customerEmail,
    this.customerId,
    this.customerFirstName,
    this.customerLastName,
    this.baseGrandTotal,
    this.grandTotal,
    this.baseCurrencyCode,
    this.orderCurrencyCode,
    this.items,
    this.billingAddress,
    this.shippingAddress,
    this.payment,
    this.shipping,
    this.extensionAttributes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      entityId: json['entity_id'],
      incrementId: json['increment_id'],
      status: json['status'],
      state: json['state'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      customerEmail: json['customer_email'],
      customerId: json['customer_id'],
      customerFirstName: json['customer_firstname'],
      customerLastName: json['customer_lastname'],
      baseGrandTotal: json['base_grand_total'] != null
          ? double.tryParse(json['base_grand_total'].toString())
          : null,
      grandTotal: json['grand_total'] != null
          ? double.tryParse(json['grand_total'].toString())
          : null,
      baseCurrencyCode: json['base_currency_code'],
      orderCurrencyCode: json['order_currency_code'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : null,
      billingAddress: json['billing_address'] != null
          ? OrderBillingAddress.fromJson(json['billing_address'])
          : null,
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(json['shipping_address'])
          : null,
      payment: json['payment'] != null
          ? Payment.fromJson(json['payment'])
          : null,
      shipping: json['extension_attributes']?['shipping_assignments'] != null
          ? Shipping.fromJson(
              json['extension_attributes']['shipping_assignments'][0])
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? OrderExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (entityId != null) 'entity_id': entityId,
      if (incrementId != null) 'increment_id': incrementId,
      if (status != null) 'status': status,
      if (state != null) 'state': state,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (customerEmail != null) 'customer_email': customerEmail,
      if (customerId != null) 'customer_id': customerId,
      if (customerFirstName != null) 'customer_firstname': customerFirstName,
      if (customerLastName != null) 'customer_lastname': customerLastName,
      if (baseGrandTotal != null) 'base_grand_total': baseGrandTotal,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (baseCurrencyCode != null) 'base_currency_code': baseCurrencyCode,
      if (orderCurrencyCode != null) 'order_currency_code': orderCurrencyCode,
      if (items != null) 'items': items!.map((i) => i.toJson()).toList(),
      if (billingAddress != null) 'billing_address': billingAddress!.toJson(),
      if (shippingAddress != null)
        'shipping_address': shippingAddress!.toJson(),
      if (payment != null) 'payment': payment!.toJson(),
    };
  }
}

/// Order item model
class OrderItem {
  final int? itemId;
  final String? sku;
  final String? name;
  final double? price;
  final double? qtyOrdered;
  final double? qtyShipped;
  final double? rowTotal;
  final String? productType;
  final OrderExtensionAttributes? extensionAttributes;

  OrderItem({
    this.itemId,
    this.sku,
    this.name,
    this.price,
    this.qtyOrdered,
    this.qtyShipped,
    this.rowTotal,
    this.productType,
    this.extensionAttributes,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['item_id'],
      sku: json['sku'],
      name: json['name'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      qtyOrdered: json['qty_ordered'] != null
          ? double.tryParse(json['qty_ordered'].toString())
          : null,
      qtyShipped: json['qty_shipped'] != null
          ? double.tryParse(json['qty_shipped'].toString())
          : null,
      rowTotal: json['row_total'] != null
          ? double.tryParse(json['row_total'].toString())
          : null,
      productType: json['product_type'],
      extensionAttributes: json['extension_attributes'] != null
          ? OrderExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (itemId != null) 'item_id': itemId,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (qtyOrdered != null) 'qty_ordered': qtyOrdered,
      if (qtyShipped != null) 'qty_shipped': qtyShipped,
      if (rowTotal != null) 'row_total': rowTotal,
      if (productType != null) 'product_type': productType,
    };
  }
}

/// Billing address model for order
class OrderBillingAddress {
  final int? entityId;
  final String? firstName;
  final String? lastName;
  final String? company;
  final List<String>? street;
  final String? city;
  final String? region;
  final String? regionCode;
  final int? regionId;
  final String? postcode;
  final String? countryId;
  final String? telephone;
  final String? email;

  OrderBillingAddress({
    this.entityId,
    this.firstName,
    this.lastName,
    this.company,
    this.street,
    this.city,
    this.region,
    this.regionCode,
    this.regionId,
    this.postcode,
    this.countryId,
    this.telephone,
    this.email,
  });

  factory OrderBillingAddress.fromJson(Map<String, dynamic> json) {
    return OrderBillingAddress(
      entityId: json['entity_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      company: json['company'],
      street: json['street'] != null ? List<String>.from(json['street']) : null,
      city: json['city'],
      region: json['region'],
      regionCode: json['region_code'],
      regionId: json['region_id'],
      postcode: json['postcode'],
      countryId: json['country_id'],
      telephone: json['telephone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (entityId != null) 'entity_id': entityId,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
      if (company != null) 'company': company,
      if (street != null) 'street': street,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (regionCode != null) 'region_code': regionCode,
      if (regionId != null) 'region_id': regionId,
      if (postcode != null) 'postcode': postcode,
      if (countryId != null) 'country_id': countryId,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
    };
  }
}

/// Shipping address model
class ShippingAddress {
  final int? entityId;
  final String? firstName;
  final String? lastName;
  final String? company;
  final List<String>? street;
  final String? city;
  final String? region;
  final String? regionCode;
  final int? regionId;
  final String? postcode;
  final String? countryId;
  final String? telephone;
  final String? email;

  ShippingAddress({
    this.entityId,
    this.firstName,
    this.lastName,
    this.company,
    this.street,
    this.city,
    this.region,
    this.regionCode,
    this.regionId,
    this.postcode,
    this.countryId,
    this.telephone,
    this.email,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      entityId: json['entity_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      company: json['company'],
      street: json['street'] != null ? List<String>.from(json['street']) : null,
      city: json['city'],
      region: json['region'],
      regionCode: json['region_code'],
      regionId: json['region_id'],
      postcode: json['postcode'],
      countryId: json['country_id'],
      telephone: json['telephone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (entityId != null) 'entity_id': entityId,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
      if (company != null) 'company': company,
      if (street != null) 'street': street,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (regionCode != null) 'region_code': regionCode,
      if (regionId != null) 'region_id': regionId,
      if (postcode != null) 'postcode': postcode,
      if (countryId != null) 'country_id': countryId,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
    };
  }
}

/// Payment model
class Payment {
  final int? entityId;
  final String? method;
  final String? additionalInformation;
  final OrderExtensionAttributes? extensionAttributes;

  Payment({
    this.entityId,
    this.method,
    this.additionalInformation,
    this.extensionAttributes,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      entityId: json['entity_id'],
      method: json['method'],
      additionalInformation: json['additional_information'] != null
          ? json['additional_information'].toString()
          : null,
      extensionAttributes: json['extension_attributes'] != null
          ? OrderExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (entityId != null) 'entity_id': entityId,
      if (method != null) 'method': method,
      if (additionalInformation != null)
        'additional_information': additionalInformation,
    };
  }
}

/// Shipping model
class Shipping {
  final ShippingMethod? method;
  final ShippingAddress? address;

  Shipping({
    this.method,
    this.address,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      method: json['method'] != null
          ? ShippingMethod.fromJson(json['method'])
          : null,
      address: json['address'] != null
          ? ShippingAddress.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (method != null) 'method': method!.toJson(),
      if (address != null) 'address': address!.toJson(),
    };
  }
}

/// Shipping method model
class ShippingMethod {
  final String? method;
  final String? methodTitle;
  final String? carrier;
  final String? carrierTitle;

  ShippingMethod({
    this.method,
    this.methodTitle,
    this.carrier,
    this.carrierTitle,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      method: json['method'],
      methodTitle: json['method_title'],
      carrier: json['carrier'],
      carrierTitle: json['carrier_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (method != null) 'method': method,
      if (methodTitle != null) 'method_title': methodTitle,
      if (carrier != null) 'carrier': carrier,
      if (carrierTitle != null) 'carrier_title': carrierTitle,
    };
  }
}

/// Extension attributes for order
class OrderExtensionAttributes {
  final Map<String, dynamic>? additionalAttributes;

  OrderExtensionAttributes({
    this.additionalAttributes,
  });

  factory OrderExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return OrderExtensionAttributes(
      additionalAttributes: json,
    );
  }

  Map<String, dynamic> toJson() {
    return additionalAttributes ?? {};
  }
}

